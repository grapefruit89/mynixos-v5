#!/usr/bin/env python3
import os
import subprocess
import datetime
import shutil
import json
import re
from pathlib import Path
import secrets
from flask import Flask, request, render_template_string, send_file, redirect, url_for, session

# Configuration
# CA-01 FIX: Use .resolve() for absolute path stability
BASE_DIR = Path("/var/lib/ca-server").resolve()
CERT_DIR = (BASE_DIR / "certs").resolve()
CERT_DIR.mkdir(parents=True, exist_ok=True)

CA_CERT = "/etc/caddy/ca.crt"
CA_KEY  = "/run/secrets/ca.key"  # Decrypted by sops-nix

app = Flask(__name__)
app.secret_key = os.environ.get("FLASK_SECRET_KEY", secrets.token_hex(32))
app.config['MAX_CONTENT_LENGTH'] = 2 * 1024 * 1024 # 2MB Limit for CSRs

def validate_csr(csr_path):
    """Deep validation of CSR using OpenSSL."""
    try:
        # Verify the CSR signature and format
        result = subprocess.run([
            "openssl", "req", "-in", str(csr_path), "-noout", "-verify"
        ], capture_output=True, text=True, check=True)
        return "verify OK" in result.stdout
    except subprocess.CalledProcessError:
        return False

HTML_TEMPLATE = """
<!doctype html>
<html lang="de">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dendritic CA Manager</title>
    <style>
        body { font-family: sans-serif; max-width: 800px; margin: 2rem auto; padding: 0 1rem; line-height: 1.5; background: #f4f4f9; }
        h2 { color: #333; border-bottom: 2px solid #ddd; padding-bottom: 0.5rem; }
        .card { background: white; padding: 1.5rem; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); margin-bottom: 2rem; }
        form { display: flex; gap: 10px; }
        input[type="text"], input[type="file"] { padding: 8px; border: 1px solid #ccc; border-radius: 4px; flex-grow: 1; }
        button { padding: 8px 16px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background: #0056b3; }
        table { width: 100%; border-collapse: collapse; margin-top: 1rem; }
        th, td { text-align: left; padding: 12px; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; }
        .btn-delete { color: #dc3545; text-decoration: none; font-weight: bold; }
        .btn-delete:hover { color: #a71d2a; }
        .hint { font-size: 0.85rem; color: #666; margin-top: 0.5rem; }
    </style>
</head>
<body>
    <h1>🚀 Dendritic CA Manager</h1>
    
    <div class="card">
        <h2>🛡️ Neues TPM-Zertifikat signieren (CSR)</h2>
        <p class="hint">Lade hier den auf deinem Admin-Laptop erzeugten CSR hoch.</p>
        <form method="post" action="/sign" enctype="multipart/form-data">
          <input type="hidden" name="csrf_token" value="{{ csrf_token }}">
          <input type="text" name="name" placeholder="Gerätename (z.B. Admin-Laptop)" required>
          <input type="file" name="csr" required>
          <button type="submit">Signieren & Download</button>
        </form>
    </div>

    <div class="card">
        <h2>📋 Zertifikats-Inventar</h2>
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Erstellt am</th>
                    <th>Aktion</th>
                </tr>
            </thead>
            <tbody>
                {% for cert in certs %}
                <tr>
                    <td><strong>{{ cert.name }}</strong></td>
                    <td>{{ cert.created }}</td>
                    <td>
                        <form method="post" action="/delete/{{ cert.id }}" style="display:inline;">
                            <input type="hidden" name="csrf_token" value="{{ csrf_token }}">
                            <button type="submit" class="btn-delete" style="background:none;border:none;padding:0;font:inherit;cursor:pointer;" onclick="return confirm('Zertifikat wirklich löschen?')">Löschen</button>
                        </form>
                    </td>
                </tr>
                {% endfor %}
                {% if not certs %}
                <tr><td colspan="3" style="text-align:center;">Noch keine Zertifikate erstellt.</td></tr>
                {% endif %}
            </tbody>
        </table>
    </div>
    
    <p class="hint">Hinweis: Löschen entfernt nur die serverseitige Kopie. Das Zertifikat bleibt technisch gültig, bis die CA-CRL aktualisiert wird.</p>
</body>
</html>
"""

@app.before_request
def generate_csrf_token():
    if "csrf_token" not in session:
        session["csrf_token"] = secrets.token_hex(16)

@app.route("/")
def index():
    certs = []
    if CERT_DIR.exists():
        for d in sorted(CERT_DIR.iterdir(), reverse=True):
            if d.is_dir():
                info_file = d / "info.json"
                if info_file.exists():
                    try:
                        info = json.loads(info_file.read_text())
                        certs.append({
                            "id": d.name,
                            "name": info.get("name", "Unknown"),
                            "created": info.get("created", "Unknown")
                        })
                    except:
                        pass
    return render_template_string(HTML_TEMPLATE, certs=certs, csrf_token=session.get("csrf_token"))

@app.route("/sign", methods=["POST"])
def sign():
    # CA-03 FIX: CSRF Validation
    if request.form.get("csrf_token") != session.get("csrf_token"):
        return "CSRF Token missing or invalid", 403

    # CA-02 FIX: Sanitize input name strictly (Whitelist regex)
    raw_name = request.form.get("name", "Unknown").strip()
    name = re.sub(r'[^a-zA-Z0-9_-]', '', raw_name)[:64]
    
    csr_file = request.files.get("csr")
    
    if not csr_file or not name:
        return "Valid Name and CSR file required", 400

    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    dir_name = f"{name}_{timestamp}"
    dir_path = (CERT_DIR / dir_name).resolve()
    
    # Safety Check: Ensure dir_path is still inside CERT_DIR
    if CERT_DIR.resolve() not in dir_path.parents:
        return "Invalid directory path", 400
        
    dir_path.mkdir(parents=True, exist_ok=True)

    csr_path = dir_path / "client.csr"
    crt_path = dir_path / "client.crt"
    csr_file.save(str(csr_path))

    # CA-04 FIX: Deep CSR Validation via OpenSSL
    if not validate_csr(csr_path):
        shutil.rmtree(dir_path)
        return "Invalid CSR content or format", 400

    # Sign the CSR with the CA
    try:
        subprocess.run([
            "openssl", "x509", "-req",
            "-in", str(csr_path),
            "-CA", CA_CERT,
            "-CAkey", CA_KEY,
            "-CAcreateserial",
            "-out", str(crt_path),
            "-days", "365",
            "-sha256"
        ], check=True, capture_output=True)
    except subprocess.CalledProcessError as e:
        shutil.rmtree(dir_path)
        return f"OpenSSL Error: {e.stderr.decode()}", 500

    # Save metadata
    info = {
        "name": name,
        "created": datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "crt_file": str(crt_path)
    }
    (dir_path / "info.json").write_text(json.dumps(info))

    return send_file(crt_path, as_attachment=True, download_name=f"{name}.crt")

@app.route("/delete/<dirname>", methods=["POST"])
def delete(dirname):
    # CA-03 FIX: CSRF Validation
    if request.form.get("csrf_token") != session.get("csrf_token"):
        return "CSRF Token missing or invalid", 403

    # CA-01 FIX: Resolve path and check parents correctly to prevent traversal
    dir_to_delete = (CERT_DIR / dirname).resolve()
    if dir_to_delete.is_dir() and (CERT_DIR.resolve() in dir_to_delete.parents):
        shutil.rmtree(dir_to_delete)
    return redirect(url_for("index"))

if __name__ == "__main__":
    # In production, this is overridden by Gunicorn binding to a Unix socket
    app.run(host="127.0.0.2", port=5000)

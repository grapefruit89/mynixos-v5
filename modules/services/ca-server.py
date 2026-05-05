#!/usr/bin/env python3
import os
import subprocess
import datetime
import shutil
import json
from pathlib import Path
from flask import Flask, request, render_template_string, send_file, redirect, url_for

# Configuration
BASE_DIR = Path("/var/lib/ca-server")
CERT_DIR = BASE_DIR / "certs"
CERT_DIR.mkdir(parents=True, exist_ok=True)

CA_CERT = "/etc/caddy/ca.crt"
CA_KEY  = "/run/secrets/ca.key"  # Decrypted by sops-nix

app = Flask(__name__)

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
                    <td><a href="/delete/{{ cert.id }}" class="btn-delete" onclick="return confirm('Zertifikat wirklich löschen?')">Löschen</a></td>
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
    return render_template_string(HTML_TEMPLATE, certs=certs)

@app.route("/sign", methods=["POST"])
def sign():
    name = request.form.get("name", "Unknown").strip().replace(" ", "_")
    csr_file = request.files.get("csr")
    
    if not csr_file or not name:
        return "Name and CSR file required", 400

    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    dir_name = f"{name}_{timestamp}"
    dir_path = CERT_DIR / dir_name
    dir_path.mkdir(parents=True, exist_ok=True)

    csr_path = dir_path / "client.csr"
    crt_path = dir_path / "client.crt"
    csr_file.save(str(csr_path))

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
        return f"OpenSSL Error: {e.stderr.decode()}", 500

    # Save metadata
    info = {
        "name": name,
        "created": datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "crt_file": str(crt_path)
    }
    (dir_path / "info.json").write_text(json.dumps(info))

    return send_file(crt_path, as_attachment=True, download_name=f"{name}.crt")

@app.route("/delete/<dirname>")
def delete(dirname):
    dir_to_delete = CERT_DIR / dirname
    if dir_to_delete.is_dir() and (CERT_DIR in dir_to_delete.parents):
        shutil.rmtree(dir_to_delete)
    return redirect(url_for("index"))

if __name__ == "__main__":
    app.run(host="127.0.0.2", port=5000)

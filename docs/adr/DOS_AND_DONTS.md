# 📜 Der Kodex: DOS AND DON'TS (v7.1 Strict)

Dieses Dokument ist das architektonische Fundament des NixHome-Projekts. Verstöße gegen diese Regeln werden durch automatisierte Quality Gates (Titan-Guard) und Build-Assertions blockiert.

---

## 🛑 DON'TS (Verboten)

### 1. Externe Flake-Abhängigkeiten
- **Regel:** Keine Flake-Inputs außer `nixpkgs` und `sops-nix` (oder explizit genehmigte Kern-Bibliotheken).
- **Grund:** Zero Trust in der Supply Chain. Jede Abhängigkeit erhöht die Angriffsfläche und die Komplexität.
- **Anti-Pattern:** Nutzung von `flake-parts`, `devshell`, `flake-utils`.

### 2. Docker & Container-Virtualisierung
- **Regel:** Kein `virtualisation.docker.enable = true`.
- **Grund:** Docker widerspricht dem deklarativen NixOS-Prinzip. Wir nutzen native systemd-Services mit gehärtetem Sandboxing (`mkService`).
- **Ausnahme:** Explizit genehmigte `systemd-nspawn` Container für unvertrauenswürdige Apps (Zukunftsthema).

### 3. Legacy-Dienste
- **Regel:** Kein `cron`, kein `iptables`, kein `tailscale`.
- **Grund:** Wir nutzen moderne, native Alternativen (`systemd-timers`, `nftables`, `wireguard`).

### 4. SSH-Passwörter
- **Regel:** `PasswordAuthentication` muss global deaktiviert sein.
- **Grund:** Nur hardware-gebundene Keys (TPM/YubiKey) sind erlaubt.

---

## ✅ DOS (Vorgeschrieben)

### 1. SSoT (Single Source of Truth)
- **Regel:** Jede Konfiguration muss aus der zentralen Registry (`modules/core/ports.nix`, `configs.nix`, `users/registry.nix`) abgeleitet werden.
- **Ziel:** Keine Magic Numbers oder hartkodierte IP-Adressen in App-Modulen.

### 2. Impermanence & Statelessness
- **Regel:** Das Root-Dateisystem (`/`) muss ein `tmpfs` sein. Persistenz erfolgt ausschließlich über `/persist` und muss explizit registriert werden.
- **Ziel:** Schutz gegen Configuration Drift und Schadsoftware-Persistence.

### 3. NIXMETA-Header
- **Regel:** Jede `.nix` Datei (außer `default.nix`) MUSS einen gültigen JSON-Header enthalten.
- **Ziel:** Volle Traceability und automatisierte Dokumentationsgenerierung.

### 4. East-West Isolation
- **Regel:** Dienste sprechen untereinander primär über Unix Sockets oder den geschützten Admin-Loopback (`127.0.0.2` / `::2`).
- **Ziel:** Minimierung der internen Angriffsfläche.

---

## 🛠️ Durchsetzung
Diese Regeln werden durch `modules/core/architecture-rules.nix` während der Evaluierung und durch `scripts/audit-code-quality.sh` während des CI-Prozesses erzwungen.

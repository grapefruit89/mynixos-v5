# 00-core Foundation Design (hardened)

## 1. Übersicht & Ziel
Das Ziel ist die absolute Festigung des `00-core` Layers (Das Fundament). Bevor höhere Layer (wie Media, Apps oder Gateway) konfiguriert werden, muss die Basis zu 100 % verlässlich, nachvollziehbar und zentralisiert sein. Alle höheren Layer sind reine Konsumenten der hier definierten Schnittstellen und Standards.

## 2. Architektur-Komponenten

### 2.1 Hardware & Boot (Die Wurzel)
Die Hardware-Abstraktion für den Q958 wird konsolidiert, damit das System deterministisch bootet und alle nötigen Treiber (z.B. für Transcoding) bereitstellt.
* **Betroffene Dateien:** `host-q958-hardware-profile.nix`, `boot-safeguard.nix`, `kernel-slim.nix`.
* **Funktion:** Sicheres Booten, Microcode-Updates, Intel QuickSync/VA-API Treiber-Init.

### 2.2 Die Fabrik: `lib-helpers.nix` (`mkService`)
Dies ist das Herzstück der Automatisierung. Die Funktion `mkService` wird zur universellen Schnittstelle für alle Dienste in den Layern 10-90 ausgebaut.
* **Betroffene Dateien:** `lib-helpers.nix`.
* **Funktion:** Ein einziger Aufruf (`mkService { name = "vaultwarden"; port = 8080; }`) generiert automatisch:
 * Systemd Hardening & Sandboxing (ProtectSystem, PrivateTmp, etc.).
 * Caddy Reverse Proxy VirtualHosts (inkl. SSO/mTLS Routing).
 * Optional: Firewall-Regeln und Persistenz-Pfade.

### 2.3 Das SSoT-Register (Single Source of Truth)
Zentrale Verwaltung aller "Magic Strings" und Nummern, um Konfigurationsdrift zu vermeiden.
* **Betroffene Dateien:** `ports.nix`, `configs.nix`, `registry.nix`.
* **Funktion:**
 * `ports.nix`: Eindeutige Zuweisung aller Ports. Kein Dienst darf seinen Port selbst definieren.
 * `configs.nix`: Globale Variablen (Domain `nix.m7c5.de`, Admin-Mail, LAN-IPs).
 * `registry.nix`: Feature-Toggles (z.B. globale Aktivierung von Backups oder mTLS).

### 2.4 Traceability (NMS-Modell)
Metadaten-Tracking für jede Konfiguration, um bei Fehlern in zz.B. `80-monitoring` den Ursprung in `00-core` sofort lokalisieren zu können.
* **Betroffene Dateien:** `lib-helpers-meta.nix`.
* **Funktion:** Definition und Durchsetzung des `nms` (NixOS Management System) Metadaten-Standards für Audits und Versionierung.

## 3. Datenfluss & Abhängigkeiten
1. **Bottom-Up:** `configs.nix` und `ports.nix` werden zuerst geladen.
2. **Middle:** `lib-helpers.nix` nutzt die SSoT-Werte, um die `mkService` Logik zu bauen.
3. **Top-Down:** Alle Dateien in Layern >00 importieren `lib-helpers.nix` und rufen `mkService` auf.

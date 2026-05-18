# 🎮 AMP Game Server Panel Setup (Native NixOS)

Diese Dokumentation beschreibt die Einrichtung des AMP Panels ohne Docker in der gehärteten `repo_v5` Umgebung.

## 🏗️ Architektur
AMP läuft in einer **FHS-Sandbox** (`buildFHSEnv`), die alle benötigten Bibliotheken (.NET 8, glibc, etc.) bereitstellt. Die Daten werden über **Impermanence** unter `/persist/var/lib/amp` gesichert.

## 🚀 Erstmalige Einrichtung (Bootstrapping)

1.  **System-Rebuild:** Führe einen `nixos-rebuild switch` aus, um den `amp` User und die Sandbox zu erstellen.
2.  **Bootstrap-Skript ausführen:**
    ```bash
    sudo bash scripts/bootstrap-amp.sh
    ```
3.  **Innerhalb der FHS-Shell (als User `amp`):**
    ```bash
    wget https://repo.cubecoders.com/ampinstmgr.zip
    unzip ampinstmgr.zip
    ./ampinstmgr QuickStart <DEINE_LIZENZ_NUMMER>
    ```
4.  **Service starten:**
    Verlasse die Shell (`exit`) und starte den Service:
    ```bash
    sudo systemctl enable --now amp
    ```

## 🌐 Zugriff
Das Panel ist unter `https://amp.<deine-domain>` erreichbar. 
Der Zugriff ist auf die **Admin-Zone** beschränkt (`admin_auth`).

## 🛡️ Sicherheit & Härtung
-   **Sandbox:** `ProtectSystem=strict`, `NoNewPrivileges=true`.
-   **Netzwerk:** `PrivateNetwork=false` (notwendig für Game-Server).
-   **User:** Eigener unprivilegierter System-User `amp` mit statischer UID `2109`.

## 📂 Pfade
-   **State:** `/var/lib/amp` (Persistent via `/persist/var/lib/amp`).
-   **Binaries:** Werden von `ampinstmgr` direkt in das State-Verzeichnis geladen.

## 🔧 Game-Ports öffnen
Standardmäßig sind keine Game-Ports in der Firewall geöffnet. Um Ports für ein bestimmtes Spiel (z.B. Minecraft 25565) zu öffnen, passe `modules/core/firewall.nix` an:

```nix
networking.firewall.allowedTCPPorts = [ 25565 ];
networking.firewall.allowedUDPPorts = [ 25565 ];
```
Oder nutze die `extraInputRules`.

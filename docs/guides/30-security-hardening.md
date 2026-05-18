# Cluster 30: Security Hardening

### Inhalt aus `GUIDE-Aviation-Grade-Hardening-srvos.md`

---
title: 🛡️ Aviation-Grade Hardening (srvos Pattern)
category: architecture/security
status: [ACTIVE-SSoT]
capabilities: [process-isolation, systemd-sandboxing, gpu-binding, srvos-standard]
sources: [numtide/srvos, systemd.exec(5)]
---

# 🛡️ Hardening: Der srvos-Standard

In mynixos nutzen wir das **srvos Pattern** (Numtide), um Dienste maximal zu isolieren, ohne die Hardware-Beschleunigung zu verlieren.

## 🏛️ 1. Das GPU-Paradoxon gelöst
Bisher bedeutete GPU-Zugriff oft den Verzicht auf `PrivateDevices`. Wir nutzen jetzt **BindPaths**.
- **Konzept:** Wir setzen `PrivateDevices = true`, binden aber den Render-Node explizit wieder in den Sandbox-Namespace ein.
- **Vorteil:** Der Dienst sieht die GPU, aber keine anderen physischen Geräte des Hosts. ✅

## ⚙️ 2. Der Hardening-Blueprint
Jeder Dendrit folgt diesem Sicherheits-Standard in der `serviceConfig`:
```nix
NoNewPrivileges = true;
ProtectSystem = "strict";
ProtectHome = true;
PrivateTmp = true;
PrivateDevices = true;
BindPaths = [ "/dev/dri/renderD128" ]; # Nur wenn GPU nötig
CapabilityBoundingSet = [ "" ];
```

## 🚀 SRE-Vorteil
Dieser Standard senkt die Angriffsfläche drastisch. Ein kompromittierter Dienst kann weder das Dateisystem modifizieren noch andere Hardware-Komponenten scannen.

---

### Inhalt aus `GUIDE-Kernel-Mastery-Hardening.md`

---
title: 🛡️ Kernel Mastery & Hardening (Layer 00-core)
category: architecture/core
status: [ACTIVE-SSoT]
capabilities: [kernel-selection, sysctl-hardening, intel-microcode, zfs-compatibility]
sources: [nixpkgs/nixos/modules/system/boot/kernel.nix, hardened profile]
---

# 🛡️ Der mynixos Kernel-Standard

In mynixos folgen wir dem Prinzip der "Maximum Stability & Purity". Der Kernel ist das Herzstück unserer SRE-Strategie.

## 🏛️ 1. Kernel-Wahl (Stability vs. Features)
Für den Tower nutzen wir den **LTS-Kernel** oder den **Hardened-Kernel**.
- **Dienst:** `boot.kernelPackages = pkgs.linuxPackages_hardened;`
- **Vorteil:** Maximale Sicherheit gegen Zero-Day-Exploits.
- **Wichtig:** Wir prüfen immer die ZFS-Kompatibilität (ADR-006).

## 🛡️ 2. Sysctl Hardening (Network & Panic)
Wir zementieren die Sicherheits-Parameter direkt im Kernel-Laufzeit-Modul.
```nix
boot.kernel.sysctl = {
  # Automatischer Reboot nach 10 Sek. bei Kernel Panic (Headless Pflicht!)
  "kernel.panic" = 10;
  # Schutz vor IP-Spoofing
  "net.ipv4.conf.all.rp_filter" = 1;
  # Deaktiviere ICMP Redirects (Schutz vor MITM)
  "net.ipv4.conf.all.accept_redirects" = 0;
  "net.ipv4.conf.all.send_redirects" = 0;
};
```

## 💎 3. Intel-Microcode (Security-Fixes)
Wir erzwingen die neuesten Microcode-Patches für den i3-9100.
- **Dienst:** `hardware.cpu.intel.updateMicrocode = true;`

## 🚀 SRE-Anwendung
Der Kernel wird so konfiguriert, dass er im Fehlerfall (Panic) selbstständig versucht, das System neu zu starten. Da der Tower headless ist, ist dies unsere einzige Rettung bei schweren Fehlern.

---

### Inhalt aus `GUIDE-Kernel-Surgical-Diet.md`

---
title: ✂️ Kernel Surgical Diet (Layer 00-core)
category: architecture/core
status: [ACTIVE-SSoT]
capabilities: [legacy-ejection, hardware-optimization, attack-surface-reduction]
sources: [Linux Kernel Config Reference, Gentoo Minimal Kernel Guide]
---

# ✂️ Kernel-Diät: Nur das, was dein Q958 wirklich braucht

In mynixos lehnen wir monolithischen Bloat ab. Wir schalten alles ab, was vor 2015 relevant war oder nur in Rechenzentren existiert.

## 🏛️ 1. Die Ejektions-Liste (What's Gone)
Wir deaktivieren folgende Subsysteme via `boot.kernelPatches` oder `boot.kernel.sysctl`:
- **Amateurfunk:** AX.25, Rose, NET/ROM (HAMRADIO).
- **Legacy Networking:** Appletalk, IPX, X.25, Token Ring.
- **Legacy Storage:** Floppy, CD-ROM (ISO9660), IDE (alt).
- **Enterprise-Bloat:** InfiniBand, FiberChannel, DCM (Data Center Management).

## ⚙️ 2. Die NixOS Umsetzung (The Slim-Profile)
Hier ist das Muster für deinen Dendriten (`modules/00-core/kernel-slim.nix`):

```nix
boot.kernelPatches = [ {
  name = "mynixos-slim-diet";
  patch = null;
  extraConfig = ''
    # Amateurfunk raus
    HAMRADIO n
    AX25 n
    # Legacy Hardware raus
    FIREWIRE n
    ISDN n
    # Enterprise Bloat raus
    INFINIBAND n
    SCSI_LOWLEVEL n
  '';
} ];
```

## 🛡️ 3. SRE-Vorteil
- **Speed:** Schnellere Boot-Zeiten, da weniger Treiber initialisiert werden müssen.
- **Security:** Was nicht geladen ist, kann nicht angegriffen werden (Zero-Day Schutz). ✅
- **Memory:** Kleinerer Kernel-Footprint lässt mehr RAM für deine Dienste.

## 🚀 SRE-Anwendung
Diese Konfiguration wird in `90-policy/no-legacy.nix` erzwungen. Werden Treiber aus der Ejektions-Liste angefordert, bricht der Build mit einer Assertion ab.

---

### Inhalt aus `GUIDE-Security-Stealth-SPA.md`

---
title: 🕵️ Security Stealth SPA (Single Packet Authorization)
category: architecture/security
status: [ACTIVE-SSoT]
capabilities: [stealth-firewall, encrypted-knocking, anti-replay-protection]
sources: [nixpkgs/pkgs/tools/networking/fwknop, CipherDyne Docs]
---

# 🕵️ SPA: Die unsichtbare Firewall

In mynixos nutzen wir SPA (Single Packet Authorization), um unsere administrativen Ports (SSH) vor dem Internet zu verstecken.

## 🏛️ 1. Warum SPA statt Port Knocking?
Klassisches Klopfen ist unsicher (Replay-Attacken). SPA nutzt:
- **Verschlüsselung:** Das Klopf-Paket ist AES-verschlüsselt.
- **Signatur:** Nur autorisierte Keys können den Port öffnen.
- **Non-Standard:** Der Wächter hört passiv auf dem Netzwerk-Stack, ohne einen offenen Port zu zeigen.

## ⚙️ 2. Workflow für den SRE (Tower-Zugriff)
Um dich einzuloggen, nutzt du den automatisierten Trigger:

### Am Laptop (Linux/Mac):
```bash
# Einmalige Konfiguration in .bashrc
alias nix-ssh='fwknop -n mynixos-tower && ssh nix'
```
- **Ergebnis:** Ein Befehl öffnet die Firewall und verbindet dich. ✅

### Am Smartphone (Android/iOS):
- App: **fwknop2**. Ein Klick auf das Widget schickt den Schlüssel, danach öffnet sich deine SSH-App.

## 🛠️ 3. NixOS Implementierung
Wir nutzen das `fwknop` Modul in Layer 00-core.
- **Integration:** `fwknopd` kommuniziert direkt mit `nftables` (Kapitel 56), um dynamische Regeln für deine IP einzufügen.

## 🚀 SRE-Vorteil
Selbst wenn eine Sicherheitslücke in OpenSSH gefunden wird, ist dein Tower sicher, da der Angreifer den SSH-Dienst physisch nicht erreichen kann.

---

### Inhalt aus `GUIDE-Service-Hardening-Sandboxing.md`

---
title: 🛡️ Service Hardening & Sandboxing (Layer 90-policy)
category: architecture/security
status: [ACTIVE-SSoT]
capabilities: [process-isolation, cve-scanning, secure-hashing, sandboxing]
sources: [nixpkgs/pkgs/tools/security, Google nsjail docs, CVE-bin-tool]
---

# 🛡️ Hardening: Isolation als Standard

In mynixos gehen wir davon aus, dass jede Web-App (Layer 40/50) potenziell kompromittierbar ist. Wir minimieren den Schaden durch strikte Isolation.

## 🏛️ 1. Prozess-Isolation via nsjail (The Prison)
Wir nutzen `nsjail`, um Dienste in einen hochgradig eingeschränkten Namespace zu sperren.
- **Dienst:** `pkgs.nsjail`.
- **SRE-Vorteil:** Begrenzt Dateisystem-Zugriff, Netzwerk-Schnittstellen und System-Calls (Seccomp). ✅
- **Anwendung:** Besonders wichtig für Dienste, die untrusted Daten verarbeiten (z.B. SABnzbd oder n8n).

## 🔍 2. Proaktives CVE-Scanning
Wir nutzen `cve-bin-tool`, um den Status unserer Binaries zu überwachen.
- **Pattern:** Ein wöchentlicher systemd-Timer triggert einen Scan über `/run/current-system/sw/bin`.
- **Alerting:** Warnungen werden direkt an Matrix (Kapitel 20) gesendet.

## 🔑 3. Password-Security (`mkpasswd`)
User-Passwörter in der NixOS-Konfiguration (`users.users.<name>.passwordHash`) werden ausschließlich als Hashes hinterlegt.
- **Befehl:** `mkpasswd -m sha-512` (oder moderner Argon2).
- **Vorteil:** Selbst wenn deine `flake.nix` öffentlich wird, sind deine Passwörter sicher. ✅

## 🚀 SRE-Anwendung
Das Ziel ist "Defense in Depth". Falls die Firewall (Kapitel 56) und SPA (Kapitel 61) überwunden werden, verhindert das Sandboxing den Zugriff auf das restliche System.

---

### Inhalt aus `GUIDE-Nftables-Firewall-Mastery.md`

---
title: 🛡️ Nftables Firewall Mastery (Layer 00-core)
category: architecture/core
status: [ACTIVE-SSoT]
capabilities: [atomic-rulesets, build-time-validation, fail2ban-integration, nat-nft]
sources: [nixpkgs/nixos/modules/services/networking/nftables.nix, fail2ban.nix]
---

# 🛡️ Nftables: Die Aviation-Grade Firewall

In mynixos ist nftables das einzige erlaubte Firewall-Backend. Es ersetzt das veraltete iptables vollständig.

## 🏛️ 1. Die SRE-Konfiguration (Layer 00-core)
Wir nutzen die Build-Zeit-Validierung, um uns niemals auszusperren.
- **Dienst:**
```nix
networking.nftables = {
  enable = true;
  checkRuleset = true; # Zwingend: Validierung vor Aktivierung
};
```

## 🛡️ 2. Fail2ban Integration (Layer 30-services)
Fail2ban wird angewiesen, nativ mit nftables zu kommunizieren.
```nix
services.fail2ban = {
  enable = true;
  banaction = "nftables-multiport";
};
```

## 🌐 3. Deklaratives NAT & Port-Forwarding
Wir deklarieren Regeln nicht über Scripte, sondern über das strukturierte Ruleset-File.
- **Pattern:** Nutzung von `networking.nftables.rulesetFile`, um komplexe Tabellen (Filter, Nat, Mangle) sauber zu trennen.

## 🚀 SRE-Vorteil
- **Atomic Reload:** nftables lädt das gesamte Regelwerk atomar. Es gibt keinen Zustand, in dem die Firewall "halb offen" ist.
- **Performance:** Deutlich geringere CPU-Last bei hohen Paketraten im Vergleich zu iptables.

---

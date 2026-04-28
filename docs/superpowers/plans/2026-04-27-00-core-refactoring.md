# 00-core Refactoring Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Konsolidierung des `00-core` Layers (Hardware, SSoT-Register, mkService-Fabrik und Traceability), um eine unerschütterliche Basis für alle höheren Layer zu schaffen.

**Architecture:** Refactoring der Basis-Nix-Module. Zentralisierung von Ports in `ports.nix`, globaler Settings in `configs.nix` und Ausbau von `lib-helpers.nix` (`mkService`), um Boilerplate in Layern 10-90 zu eliminieren. Hardware-Profile werden vereinfacht.

**Tech Stack:** NixOS, Nix Language, Systemd

---

### Task 1: Hardware & Boot Konsolidierung (Die Wurzel)

**Files:**
- Modify: `temp_mynixos/00-core/host-q958-hardware-profile.nix`
- Modify: `temp_mynixos/00-core/boot-safeguard.nix`

- [ ] **Step 1: Clean up hardware profile**

Optimiere das Hardware-Profile für den Q958. Entferne veraltete oder doppelte Einträge und stelle sicher, dass Intel QuickSync/VA-API geladen werden.

```nix
# Edit temp_mynixos/00-core/host-q958-hardware-profile.nix
{ config, lib, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
  };
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
```

- [ ] **Step 2: Streamline boot safeguard**

Sorge dafür, dass `boot-safeguard.nix` nur die allernötigsten Boot-Parameter enthält, ohne das System zu überladen.

```nix
# Edit temp_mynixos/00-core/boot-safeguard.nix
{ config, lib, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "quiet" "loglevel=3" ];
  boot.tmp.cleanOnBoot = true;
}
```

- [ ] **Step 3: Test evaluation**

Run: `nix-instantiate --eval -E 'with import <nixpkgs> { }; 1'` (Or run `nix flake check` if a flake is present, just a basic syntax check).
Expected: No syntax errors in the modified files.

- [ ] **Step 4: Commit**

```bash
git add temp_mynixos/00-core/host-q958-hardware-profile.nix temp_mynixos/00-core/boot-safeguard.nix
git commit -m "refactor(core): consolidate hardware and boot configurations"
```

### Task 2: SSoT-Register Zentralisierung (Single Source of Truth)

**Files:**
- Modify: `temp_mynixos/00-core/ports.nix`
- Modify: `temp_mynixos/00-core/configs.nix`

- [ ] **Step 1: Enforce complete port registry**

Stelle sicher, dass `ports.nix` alle Ports als SSoT exportiert.

```nix
# Edit temp_mynixos/00-core/ports.nix
{ lib, ... }:
{
  options.my.ports = lib.mkOption {
    type = lib.types.attrsOf lib.types.port;
    default = {
      vaultwarden = 8222;
      jellyfin = 8096;
      paperless = 28981;
      # Other ports...
    };
    description = "Central port registry (SSoT)";
  };
}
```

- [ ] **Step 2: Define global configs**

Zentralisiere Domain und LAN-IPs in `configs.nix`.

```nix
# Edit temp_mynixos/00-core/configs.nix
{ lib, ... }:
{
  options.my.configs = {
    identity = {
      domain = lib.mkOption { type = lib.types.str; default = "m7c5.de"; };
      subdomain = lib.mkOption { type = lib.types.str; default = "nix"; };
    };
    server = {
      lanIP = lib.mkOption { type = lib.types.str; default = "192.168.2.73"; };
    };
  };
}
```

- [ ] **Step 3: Syntax check**

Run: `nix-instantiate --parse temp_mynixos/00-core/ports.nix temp_mynixos/00-core/configs.nix`
Expected: Silent return (no errors).

- [ ] **Step 4: Commit**

```bash
git add temp_mynixos/00-core/ports.nix temp_mynixos/00-core/configs.nix
git commit -m "feat(core): centralize SSoT registries for ports and configs"
```

### Task 3: Die Fabrik (mkService Helper)

**Files:**
- Modify: `temp_mynixos/00-core/lib-helpers.nix`

- [ ] **Step 1: Enhance mkService for standard reverse proxy routing**

Erweitere `mkService` so, dass es Systemd-Sandboxing und Caddy-Reverse-Proxy-Logik nahtlos kapselt.

```nix
# Edit temp_mynixos/00-core/lib-helpers.nix
{ lib, ... }:
let
  # Fallback helper for missing dns-map
  getDomain = config: name: "${name}.${config.my.configs.identity.subdomain}.${config.my.configs.identity.domain}";
in {
  mkService = { config, name, port ? null, useSSO ? true, description ? "Managed Service", netns ? null }:
  let
    finalPort = if port != null then port else config.my.ports.${name};
    targetUrl = "http://${if netns != null then "10.200.1.2" else "127.0.0.1"}:${toString finalPort}";
    hostName = getDomain config name;
  in {
    systemd.services.${name}.serviceConfig = {
      Description = description;
      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
      NoNewPrivileges = true;
    };

    services.caddy.virtualHosts.${hostName}.extraConfig = ''
      ${lib.optionalString useSSO "import sso_auth"}
      reverse_proxy ${targetUrl}
    '';
  };
}
```

- [ ] **Step 2: Syntax check**

Run: `nix-instantiate --parse temp_mynixos/00-core/lib-helpers.nix`
Expected: Silent return (no errors).

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/00-core/lib-helpers.nix
git commit -m "feat(core): expand mkService factory for unified service definitions"
```

### Task 4: Traceability Integration

**Files:**
- Modify: `temp_mynixos/00-core/lib-helpers-meta.nix`

- [ ] **Step 1: Define NMS metadata schema**

Implementiere das NMS (NixOS Management System) Metadaten-Schema, um Traceability für Audits sicherzustellen.

```nix
# Edit temp_mynixos/00-core/lib-helpers-meta.nix
{ lib, ... }:
{
  options.my.meta = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        id = lib.mkOption { type = lib.types.str; };
        title = lib.mkOption { type = lib.types.str; };
        layer = lib.mkOption { type = lib.types.int; };
        audit.last_reviewed = lib.mkOption { type = lib.types.str; };
      };
    });
    default = {};
    description = "NMS Traceability Metadata";
  };
}
```

- [ ] **Step 2: Syntax check**

Run: `nix-instantiate --parse temp_mynixos/00-core/lib-helpers-meta.nix`
Expected: Silent return (no errors).

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/00-core/lib-helpers-meta.nix
git commit -m "feat(core): implement NMS metadata schema for traceability"
```

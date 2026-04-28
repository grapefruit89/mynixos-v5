# Navidrome Integration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Integrate Navidrome music server using the `mkStreamer` factory with ABC-Tiering and SSO.

**Architecture:** Horizontal module pattern (v5.0). Uses `myLib.mkStreamer` for standard hardening, Caddy reverse proxy, and systemd sandboxing.

**Tech Stack:** NixOS, Navidrome, Caddy.

---

### Task 1: Create Navidrome Service Module

**Files:**
- Create: `temp_mynixos/modules/apps/service-app-navidrome.nix`

- [ ] **Step 1: Write the module code**

```nix
{ config, lib, pkgs, myLib, ... }:
let
  nms = {
    id = "NIXH-01-APP-NAV-001";
    title = "Navidrome (Aviation-Grade Music Server)";
    layer = 40;
    audit.last_reviewed = "2026-04-28";
  };
  cfg = config.my.apps.navidrome;
  srePaths = config.my.configs.paths;
  sreConfig = config.my.configs;
in
{
  options.my.apps.navidrome = {
    enable = lib.mkEnableOption "Navidrome Music Server";
    user = lib.mkOption { type = lib.types.str; default = "navidrome"; };
    group = lib.mkOption { type = lib.types.str; default = "media"; };
    port = lib.mkOption { type = lib.types.port; default = config.my.ports.navidrome or 4533; };
    stateDir = lib.mkOption { type = lib.types.str; default = "${srePaths.stateDir}/navidrome"; };
    cacheDir = lib.mkOption { type = lib.types.str; default = "${srePaths.tierB}/cache/navidrome"; };
    musicDir = lib.mkOption { type = lib.types.str; default = "${srePaths.mediaLibrary}/music"; };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    # 🎬 1. AVIATION-GRADE STREAMER FABRIK
    (myLib.mkStreamer {
      inherit config;
      name = "navidrome";
      port = cfg.port;
      useGPU = false;
      memoryMax = "1G";
      cpuWeight = 60;
      description = "Navidrome Music Streaming";
    })

    # 🔧 2. NAVIDROME SPECIFICS
    {
      users.users.${cfg.user} = {
        isSystemUser = true;
        group = cfg.group;
        home = cfg.stateDir;
        extraGroups = [ "media" ];
      };

      services.navidrome = {
        enable = true;
        user = cfg.user;
        group = cfg.group;
        address = "127.0.0.1";
        port = cfg.port;
        musicFolder = cfg.musicDir;
        dataFolder = cfg.stateDir;
        cacheFolder = cfg.cacheDir;
        settings.EnableSubsonicApi = true;
      };

      # 🔗 Caddy Subdomain Override
      services.caddy.virtualHosts."music.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}" =
        config.services.caddy.virtualHosts."navidrome.${sreConfig.identity.subdomain}.${sreConfig.identity.domain}";

      systemd.services.navidrome.serviceConfig.ReadOnlyPaths = [ cfg.musicDir ];

      systemd.tmpfiles.rules = [
        "d ${cfg.stateDir} 0750 ${cfg.user} ${cfg.group} -"
        "d ${cfg.cacheDir} 0750 ${cfg.user} ${cfg.group} -"
      ];

      environment.persistence."/persist".directories = [
        "/var/lib/navidrome"
      ];
    }
  ]);
}
```

- [ ] **Step 2: Verify syntax (Dry Run)**

Run: `nix-instantiate --parse temp_mynixos/modules/apps/service-app-navidrome.nix`
Expected: File content printed (no errors).

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/modules/apps/service-app-navidrome.nix
git commit -m "feat(apps): add navidrome service module with mkStreamer"
```

---

### Task 2: Update Media Stack Permissions

**Files:**
- Modify: `temp_mynixos/modules/apps/media-stack.nix`

- [ ] **Step 1: Add navidrome to media group members**

Add `"navidrome"` to the list in `users.groups.media.members`.

- [ ] **Step 2: Commit**

```bash
git add temp_mynixos/modules/apps/media-stack.nix
git commit -m "chore(media): add navidrome user to shared media group"
```

---

### Task 3: Profile Integration and Activation

**Files:**
- Modify: `temp_mynixos/profiles/media-beast.nix`

- [ ] **Step 1: Add import for navidrome module**

Add `../modules/apps/service-app-navidrome.nix` to `imports`.

- [ ] **Step 2: Enable the service**

Add `my.apps.navidrome.enable = true;` to the config.

- [ ] **Step 3: Commit**

```bash
git add temp_mynixos/profiles/media-beast.nix
git commit -m "feat(profile): activate navidrome in media-beast profile"
```

---

### Task 4: Final Validation

- [ ] **Step 1: Run Flake Check**

Run: `nix flake check temp_mynixos/`
Expected: SUCCESS

- [ ] **Step 2: Update Project Log**

Update `GEMINI.md` to mark Navidrome as DONE.

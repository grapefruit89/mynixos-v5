# Specification: Hardening 'Tools' NixOS Modules

**Status:** Draft
**Date:** 2026-05-09
**Topic:** Audit and hardening of application modules in `temp_mynixos/modules/apps/`.

## 1. Goal
Harden the 'Tools' NixOS modules according to established architectural standards, ensuring path hygiene, secret handling, service dependencies, systemd sandboxing, and correct port/Caddy integration.

## 2. Targeted Modules
1. `service-app-vaultwarden.nix`
2. `service-app-miniflux.nix`
3. `service-app-linkwarden.nix`
4. `service-app-filebrowser.nix`
5. `service-app-readeck.nix`
6. `service-app-monica.nix`

## 3. Global Changes

### 3.1 Port Registry
- Add `readeck = 8072;` to `temp_mynixos/modules/core/ports.nix`.

### 3.2 Persistence
- Register state directories in `temp_mynixos/modules/core/impermanence.nix` under `environment.persistence."/persist".directories`:
    - `/var/lib/vaultwarden`
    - `/var/lib/miniflux`
    - `/var/lib/linkwarden`
    - `/var/lib/filebrowser`
    - `/var/lib/readeck`
    - `/var/lib/monica`

## 4. Module Hardening Details

### 4.1 Vaultwarden
- **Path**: Replace `/var/lib/vaultwarden` with `${config.my.configs.paths.stateDir}/vaultwarden`.
- **Sandboxing**:
    - Add `ProtectHome = true;`
    - Update `OOMScoreAdjust = 300;`
- **Integrity**: Verify `environmentFile` uses `config.sops.secrets`.

### 4.2 Miniflux
- **Dependencies**: Add `after = [ "postgresql.service" ];` to `systemd.services.miniflux`.
- **Sandboxing**:
    - Ensure `StateDirectory = "miniflux";` is explicitly set in `serviceConfig`.
    - Verify `DynamicUser = true;` usage.

### 4.3 Linkwarden
- **Dependencies**: Add `after = [ "postgresql.service" ];`.
- **Secrets**: Uncomment and enable `environmentFile = config.sops.secrets.linkwarden_env.path;`.
- **Sandboxing**:
    - Ensure `StateDirectory = "linkwarden";`.
    - Verify `ProtectHome = true;` and `OOMScoreAdjust = 300;`.

### 4.4 Filebrowser
- **Path**: Replace `/var/lib/filebrowser` with `${config.my.configs.paths.stateDir}/filebrowser`.
- **Sandboxing**:
    - Add `OOMScoreAdjust = 300;`.
    - Ensure `ReadWritePaths` includes the new state directory path.

### 4.5 Readeck
- **Sandboxing**:
    - Change `ProtectSystem` from `"full"` to `"strict"`.
    - Add `StateDirectory = "readeck";`.
- **Secrets**: Verify `environmentFile` usage.

### 4.6 Monica
- **Dependencies**: Add `after = [ "postgresql.service" ];`.
- **Path**: Replace all `/var/lib/monica` instances with `${config.my.configs.paths.stateDir}/monica`.
- **Activation Script**: Update to use `${config.my.configs.paths.stateDir}/monica`.
- **Sandboxing**:
    - Add `OOMScoreAdjust = 300;`.
    - Update `ReadWritePaths` in `phpfpm-monica` service.

## 5. Verification Plan
- Syntax check each modified Nix file using `nix-instantiate --parse`.
- Verify all registered ports are unique in `ports.nix`.
- Confirm persistence paths match those used in the service modules.

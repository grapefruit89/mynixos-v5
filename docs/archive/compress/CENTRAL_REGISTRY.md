# NixHome Central String Registry Design (v6.1)

## 1. Status Quo Evaluation

### Centralized Strings (Compliant)
Currently, the following categories are successfully centralized:
- **Ports:** `repo_v5/modules/core/ports.nix` (SSoT for all TCP fallbacks).
- **Zones:** `repo_v5/modules/core/configs.nix` (centralized as `zones.admin`, `zones.public`, etc.).
- **Paths:** `repo_v5/modules/core/configs.nix` (SSoT for Tiered Storage: `tierA`, `tierB`, `tierC`, `stateDir`).
- **Identity:** `repo_v5/modules/core/configs.nix` (SSoT for `domain`, `subdomain`, `user`).
- **Network:** `repo_v5/modules/core/configs.nix` (SSoT for `lanIP`, `lanCidrs`, `adminVpnIPs`).
- **UIDs:** `repo_v5/modules/core/users-registry.nix` (SSoT for static UIDs 2000-2999).

### Scattered Strings (Non-Compliant)
The following strings remain decentralized across individual modules:
- **Metadata IDs:** NMS IDs (e.g., `NIXH-10-GTW-015`) are defined locally in `nms` let-blocks.
- **Capabilities:** Strings like `"network/vpn"` are locally declared; no central validation against a schema.
- **Socket Paths:** Many paths (e.g., `/run/vaultwarden/vaultwarden.sock`) are hardcoded in `services-spec.nix`.
- **Subdomain Prefixes:** Service-specific prefixes (e.g., `"dash"`, `"auth"`) are localized in `services-spec.nix`.

## 2. Proposed Unified Registry (`registry.nix`)

The `registry.nix` will serve as the single import point for all constants, aggregating existing specialized files into a cohesive object.

### Structure
```nix
# repo_v5/modules/core/registry.nix
{ lib, config, ... }: {
  imports = [
    ./configs.nix
    ./ports.nix
    ./users-registry.nix
  ];

  options.my.registry = {
    # New: Schema for metadata validation
    schema = {
      layers = lib.mkOption { 
        type = lib.types.listOf lib.types.str;
        default = [ "00-core" "10-gateway" "20-infra" "30-security" "40-media" "50-apps" "80-users" "90-policy" ];
      };
      capabilities = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "network/ingress" "security/ssh" "storage/mover" ... ];
      };
    };
    
    # New: Centralized Socket Paths
    sockets = lib.mkOption {
      type = lib.types.attrsOf lib.types.path;
      default = {
        postgres = "/run/postgresql/.s.PGSQL.5432";
        valkey = "/run/redis-valkey/redis.sock";
        caddyAdmin = "/run/caddy/admin.sock";
      };
    };
  };
}
```

## 3. NIXMETA Integration

The registry will serve as the **Validator** for the machine-readable NIXMETA header system:

1.  **Validation:** The Nix-based metadata scraper will import `my.registry.schema` to ensure every module uses approved `layer` and `provides_capabilities` strings.
2.  **Automation:** The `dependency_graph.json` generator will use the registry to resolve physical paths (sockets, ports) used by capabilities, mapping logical dependencies to physical infrastructure.
3.  **Consistency:** Changes to the `registry.nix` (e.g., renaming a zone) will trigger validation errors in all NIXMETA headers that are no longer compliant, ensuring zero drift between architecture and documentation.

## 4. Verification Check
Objective 1 verification confirms:
- **IP 192.168.2.46:** 0 occurrences (COMPLIANT).
- **"admin-hangar":** 0 occurrences in code; 1 occurrence in documentation (`SERVICES_GUIDE.md`) (COMPLIANT).

# 📑 Services Specification (SSoT)

The file `repo_v5/services-spec.nix` is the Single Source of Truth for all services.

## Logic Overview
The spec defines a set of services, each with:
- **Port:** (Internal, still used for documentation/mapping even if proxied via Unix Sockets).
- **Subdomain:** The public-facing name (e.g., `vault.home.arpa`).
- **Zone:** `admin-hangar`, `family-pocketid`, or `public`.

## Automated Consumers
1. **Caddy Module:** Iterates over the spec to create `services.caddy.virtualHosts`. It automatically appends Admin-Auth snippets or Forward-Auth configuration based on the `zone`.
2. **Firewall Module:** Uses the `zone` to determine if a service should listen on `127.0.0.1` (Family) or `127.0.0.2` (Admin).
3. **Internal Registry:** Provides a lookup function for other Nix modules to find service addresses.

## Adding a New Service
To add a service, update `services-spec.nix`:
```nix
my-new-app = {
  port = 1234;
  subdomain = "new-app";
  zone = "admin-hangar";
};
```
The firewall and proxy configuration will update automatically on next `nixos-rebuild`.

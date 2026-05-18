# RAM Isolation Hardening (v6.1)

This document summarizes the RAM protection mechanisms active in NixHome v6.1 to ensure process isolation and kernel integrity.

## Kernel Hardening (Sysctl)
The following kernel parameters are enforced to restrict visibility and performance monitoring:
- `kernel.kexec_load_disabled = 1`: Disables the kexec mechanism, preventing the loading of a new kernel at runtime.
- `kernel.kptr_restrict = 2`: Hides kernel symbols from all unprivileged users (even with %p).
- `kernel.perf_event_paranoid = 3`: Restricts use of the performance monitoring system to the root user only.
- `kernel.unprivileged_userns_clone = 0`: Disables unprivileged user namespaces.
- `vm.unprivileged_userfaultfd = 0`: Mitigates heap grooming by restricting userfaultfd to privileged users.

## File System Isolation
- **/proc Hiding**: The `/proc` filesystem is mounted with `hidepid=2`. This ensures that users can only see their own processes, preventing information leakage about other running services.
- **Stateless Root**: The root filesystem is on `tmpfs` (RAM), ensuring a clean state on every boot and preventing persistent malware from residing on the root partition.

## Service Factory Hardening (mkService)
All services generated via `mkService` inherit the following RAM and network isolation defaults:

### Memory Limits
- `MemoryHigh = "500M"`: Soft limit. Systemd will throttle the service if it exceeds this threshold to reclaim memory.
- `MemoryMax = "1G"`: Hard limit. The service will be killed if it exceeds this threshold to prevent OOM exhaustion of the entire system.
- `mkStreamer` overrides: High-performance streaming services (Jellyfin, Navidrome) use `MemoryHigh = "75%"` and `MemoryMax = "2G"` (default) to account for transcoding and large library caches.

### Network Isolation
- `IPAddressDeny = "any"`: By default, services have no direct access to the network. They must communicate via Unix sockets or be explicitly granted access (e.g., via `IPAddressAllow`).

### Process Sandboxing
- `ProtectProc = invisible`: Complements `hidepid=2` at the service level.
- `RestrictNamespaces = true`: Prevents services from creating new namespaces (user, network, pid, etc.).
- `NoNewPrivileges = true`: Prevents processes from gaining new privileges via `execve()`.

## Manual Review Recommendations
- **Postgres/Pocket-ID Limits**: Monitor services like `postgresql` or `pocket-id` to ensure `MemoryHigh = "500M"` does not trigger premature throttling under heavy load.
- **IPAddressDeny Impact**: Verify that internal communications between services (e.g., Gatus -> Pocket-ID) are correctly handled via Unix sockets or explicit whitelist entries.

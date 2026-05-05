# 🗄️ Database & Socket Hardening

Technical details of the Unix Socket migration for PostgreSQL and Valkey.

## PostgreSQL
- **Config:** `port = 0` (TCP listener disabled).
- **Socket Path:** `/run/postgresql/`
- **Isolation:** `PrivateNetwork = true` in systemd.
- **Client Access:** Applications must use `host = /run/postgresql`.

## Valkey (Redis)
- **Config:** `port = 0`.
- **Isolation Pattern:** `mkDocumentApp` factory creates per-instance sockets.
- **Paths:** `/run/redis-valkey/app-name.sock`.
- **Permissions:** Restricted to service user/group.

## Application Integration
| App | Method | Connection Target |
|-----|--------|-------------------|
| Vaultwarden | Socket Activation | `/run/vaultwarden/vaultwarden.sock` |
| Miniflux | Socket Activation | `/run/miniflux/miniflux.sock` |
| Netdata | Unix Bind | `/run/netdata/netdata.sock` |
| Paperless-ngx | DB Socket | `/run/postgresql` |
| n8n | DB Socket | `/run/postgresql` |

## Performance Benefits
- **Zero Network Overhead:** No TCP/IP headers, no checksums, no routing logic.
- **Direct Memory Copy:** Kernel-level `sendmsg`/`recvmsg` optimization.
- **Latency:** ~10-20% reduction in high-frequency inter-service queries.

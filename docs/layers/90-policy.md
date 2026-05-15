# 📂 Security & Policy

| ID | Modul | Capabilities | Beschreibung |
| :--- | :--- | :--- | :--- |
| `NIXH-90-POL-001` | **Binary-Only Policy** | `policy/enforcement, system/stability` | Enforces a strict download-only workflow by forbidding local compilation to protect system resources. |
| `NIXH-90-POL-001` | **Aviation Security Policy Guard** | `-` | Monitors system integrity. Currently configured for non-blocking warnings. |
| `NIXH-90-POL-002` | **Runtime Security Watchdog** | `-` | Checks active system state (not just config) and alerts on violations. |
| `NIXH-90-POL-003` | **No Legacy** | `policy/enforcement, security/hardening` | Blocks legacy services and insecure protocols. |


--- 
*Generated from Nix Metadata v5.0*
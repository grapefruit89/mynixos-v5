# 🛰️ NixHome MetaBibliothek (v5.0 - Horizontal Responsibility)

Welcome to the **Aviation-Grade SRE Center**. This repository manages the Fujitsu Q958 Homelab using a modular, horizontal architecture designed for maximum security, isolation, and maintainability.

---

### 📂 Horizontal Architecture (The Silos)

Following the **V5.0 "Horizontal Responsibility"** paradigm, the repository is organized into specialized functional silos rather than vertical layers:

*   **[hardware/](./hardware/)**: Hardware-specific configurations (e.g., `q958`). Contains BIOS settings, disk layouts, and low-level registry mappings.
*   **[modules/](./modules/)**: Functional logic building blocks.
    *   **core/**: System essentials (Boot, Network, Impermanence, ABC-Tiering).
    *   **apps/**: Hardened application modules (Automation, Knowledge, Media).
    *   **services/**: Infrastructure services (Caddy M1 Abrams, Tailscale, SSO).
    *   **security/**: Hardened core, binary-only policies, and security assertions.
*   **[profiles/](./profiles/)**: Mission-ready bundles. These integrate multiple modules into cohesive system personalities (e.g., `base-server`, `media-beast`).
*   **[users/](./users/)**: Isolated user identities (Moritz, Freund). Manages Home-Manager configs and personal preferences.

---

### 🏆 SRE Standards & Patterns

*   **`mkService` Factory**: A standardized factory for all web applications. It automatically applies **Titanium Hardening**, Caddy Reverse Proxy (with SSO), and ABC-Tiering persistence.
*   **Impermanence (Tier A)**: The root filesystem is volatile. Only explicitly defined paths in `/persist` (Tier A) survive a reboot.
*   **ABC-Tiering Storage**:
    *   **Tier A (NVMe)**: System state & critical databases (`/persist`).
    *   **Tier B (SSD)**: Cache, transcodes, and active logs.
    *   **Tier C (HDD)**: Bulk media archive and cold backups.
*   **Aviation-Grade Hardening**: Kernel module locking, systemd sandboxing, and strict service slimming.

---

### 🚀 Key Mission Profiles
*   **[base-server.nix](./profiles/base-server.nix)**: The fundamental system core.
*   **[media-beast.nix](./profiles/media-beast.nix)**: Full-throttle entertainment stack with GPU acceleration.
*   **[security-hardened.nix](./profiles/security-hardened.nix)**: Maximum isolation for critical infrastructure.

---
*Last Sync: 2026-04-28 | Architecture Version: 5.0 (Horizontal)*

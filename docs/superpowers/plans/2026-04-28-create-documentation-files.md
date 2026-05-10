# Create Documentation Files Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create four Markdown files (FRONTEND.md, BACKEND.md, STORAGE_STRATEGY.md, SECURITY_ASSERTIONS.md) in the root directory documenting the project's frontend, backend, storage strategy, and security assertions based on existing NixOS configurations.

**Architecture:** Documentation only. Information sourced from `GEMINI.md`, `modules/storage/storage-mover.nix`, `modules/security/security-assertions.nix`, and `modules/services/dns-map.nix`.

**Tech Stack:** Markdown.

---

### Task 1: Create FRONTEND.md

**Files:**
- Create: `C:\Users\morit\Documents\distiller_project\FRONTEND.md`

- [ ] **Step 1: Write FRONTEND.md content**

```markdown
# 📺 Frontend Services

Overview of user-facing services for the NixHome project.

## 🚀 Services
| Service | URL | Description |
|---------|-----|-------------|
| **Jellyfin** | [https://jellyfin.nix.m7c5.de](https://jellyfin.nix.m7c5.de) | Personal Media Server (Movies, Shows). |
| **Audiobookshelf** | [https://audiobookshelf.nix.m7c5.de](https://audiobookshelf.nix.m7c5.de) | Audiobooks and Podcasts. |
| **Navidrome** | [https://navidrome.nix.m7c5.de](https://navidrome.nix.m7c5.de) | Music Streaming (Subsonic compatible). |
| **Seerr (Jellyseerr)** | [https://jellyseerr.nix.m7c5.de](https://jellyseerr.nix.m7c5.de) | Media requests and discovery. |
| **Home Assistant** | [https://home.nix.m7c5.de](https://home.nix.m7c5.de) | Smart Home Central. |

## 🔐 Authentication
All services are protected via **Pocket-ID**.
- **Auth Portal:** [https://auth.nix.m7c5.de](https://auth.nix.m7c5.de)
- **Hint:** New users require a Pocket-ID invitation from the administrator.

## 📱 Recommended Apps
- **Jellyfin:** Swiftfin (iOS/Apple TV), Jellyfin (Android/FireTV).
- **Audiobookshelf:** Official Audiobookshelf App (iOS/Android).
- **Music:** Symfonium (Android), Plexamp (via Subsonic bridge), or Amuse.
- **Home Assistant:** Home Assistant Companion App.
```

- [ ] **Step 2: Commit**

```bash
git add FRONTEND.md
git commit -m "docs: add FRONTEND.md overview"
```

---

### Task 2: Create BACKEND.md

**Files:**
- Create: `C:\Users\morit\Documents\distiller_project\BACKEND.md`

- [ ] **Step 1: Write BACKEND.md content**

```markdown
# ⚙️ Backend & Admin Services

Administrative and automation services. Restricted access.

## ⚠️ Admin Access Only
These services are for system maintenance, automation, and backend management. 
- **Requirement:** Access via Tailscale VPN or Local LAN.
- **Protection:** All services are behind SSO (Pocket-ID) or internal authentication.

## 🛠️ Service Overview
| Category | Services |
|----------|----------|
| **Media Management** | Radarr, Sonarr, Prowlarr, Lidarr, Readarr, SABnzbd |
| **Automation** | n8n, Semaphore |
| **Document Mgmt** | Paperless-ngx |
| **Utilities** | Linkding, Miniflux, Monica, Readeck |
| **Security** | Vaultwarden, AdGuard Home |
| **Infrastructure** | Netdata, Scrutiny, Cockpit, Filebrowser |

## 🔗 Access Strategy
Services use subdomains (e.g., `radarr.nix.m7c5.de`) but are not exposed to the public internet. Tailscale is required for resolution and routing.
```

- [ ] **Step 2: Commit**

```bash
git add BACKEND.md
git commit -m "docs: add BACKEND.md overview"
```

---

### Task 3: Create STORAGE_STRATEGY.md

**Files:**
- Create: `C:\Users\morit\Documents\distiller_project\STORAGE_STRATEGY.md`

- [ ] **Step 1: Write STORAGE_STRATEGY.md content**

```markdown
# 💾 Storage Strategy & ABC-Tiering

Documentation of the NixHome multi-tier storage architecture.

## 🏗️ Storage Tiers
| Tier | Hardware | Purpose |
|------|----------|---------|
| **Tier A** | NVMe SSD | System, Database (`/persist`), Active App Data. |
| **Tier B** | SATA SSD | Download Cache, Incomplete Files, Temp storage. |
| **Tier C** | HDD (Mirror) | Bulk Media (Movies, Shows, Music), Backups. |

## 🧠 Smart Mover (SSD -> HDD)
The system uses an automated `storage-mover` service to manage Tier B space:
- **Low Threshold:** 20GB free space.
- **Target Free:** 50GB free space.
- **Logic:** Moves the oldest files from SSD to HDD.
- **Power Awareness:** Only moves if HDD is already awake (active/idle) or if space is critical (< 10GB).

## ⚡ SSD Endurance & RAM Optimization
To prolong SSD life:
- **SABnzbd Incomplete:** Stored in RAM (tmpfs) to avoid constant write cycles.
- **Jellyfin Transcoding:** Processed in RAM (`/dev/shm`).
- **Logging:** High-frequency logs are offloaded to Tier C (HDD) via Vector.

## 🛠️ Advanced Features
- **Metadata Caching:** MergerFS is configured with metadata caching to speed up file listings on spinning rust.
- **Deferred Deletes:** Large file deletions are queued to avoid system hangs during I/O spikes.
```

- [ ] **Step 2: Commit**

```bash
git add STORAGE_STRATEGY.md
git commit -m "docs: add STORAGE_STRATEGY.md"
```

---

### Task 4: Create SECURITY_ASSERTIONS.md

**Files:**
- Create: `C:\Users\morit\Documents\distiller_project\SECURITY_ASSERTIONS.md`

- [ ] **Step 1: Write SECURITY_ASSERTIONS.md content**

```markdown
# 🛡️ Security Assertions (Policy Guard)

Documentation for the Aviation-Grade Security Policy Guard (`modules/security/security-assertions.nix`).

## 🎯 Purpose
Ensures the system adheres to security best practices. It checks for firewall status, SSH configuration, kernel hardening, and storage integrity.

## 🚦 Enforcement Modes
The policy can operate in two modes:

1. **`warn` (Default):**
   - Non-blocking.
   - Violations are shown as warnings during `nixos-rebuild`.
   - Allows for "Bastelmodus" (experimental changes).

2. **`strict`:**
   - Blocking.
   - Violations trigger build failures (assertions).
   - Mandatory for stable/production state.

## ⚙️ Configuration
Toggle the mode in your configuration:
```nix
my.security.policy.mode = "strict"; # or "warn"
```

## 🔍 Tracked Rules
- Firewall enabled.
- NFTables active (Modern vs Legacy).
- SSH Root Login disabled.
- Titanium Hardened Core active.
- Kernel Lockdown status.
- Tier A storage integrity (under `/persist`).
```

- [ ] **Step 2: Commit**

```bash
git add SECURITY_ASSERTIONS.md
git commit -m "docs: add SECURITY_ASSERTIONS.md"
```

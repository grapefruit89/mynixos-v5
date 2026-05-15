# Tier A/B Synergy & Metadata Enrichment Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Allow non-wear data from Tier B to use free space on Tier A (NVMe) while strictly excluding movies and high-write downloads. Start NMS v2.3 metadata tagging.

---

### Task 1: Opportunistic Tier A Usage (The "Latenz-Jäger")

**Files:**
- Modify: `temp_mynixos/modules/core/storage.nix`

- [ ] **Step 1: Configure a Synergy-Pool for App-Data**
Create a mergerfs pool `/mnt/app-synergy` that combines Tier A (NVMe) and Tier B (SSD).
Policy: `mfs` (Most Free Space) but with a `minfreespace` of 50GB on Tier A to ensure system-critical operations always have room.

- [ ] **Step 2: Exclude High-Wear Categories**
Ensure that `downloads` and `logs` are EXPLICITLY hardcoded to Tier B or Tier C, bypassing the synergy pool.

- [ ] **Step 3: Commit**

```bash
git commit -m "perf(storage): implement opportunistic Tier A/B synergy for app data"
```

---

### Task 2: NMS v2.3 Metadata Headers (Phase 4 Prep)

**Files:**
- Modify: All `service-app-*.nix` files.

- [ ] **Step 1: Add YAML-style headers as comments**
Each file gets a header like:
```nix
# ---
# nms_id: APP-MEDIA-001
# title: Jellyfin Media Server
# capabilities: [ "streaming", "transcoding", "metadata-caching" ]
# status: "hardened"
# ---
```

- [ ] **Step 2: Commit**

```bash
git commit -m "docs: add NMS v2.3 metadata headers for RAG indexing"
```

# Inject NMS v2.3 Metadata Headers Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Inject YAML-style metadata headers (NMS v2.3) into all service app and media nix files for RAG indexing.

**Architecture:** Each nix file in `temp_mynixos/modules/apps/` will receive a 7-line header comment block at the very top. Existing headers will be replaced if present.

**Tech Stack:** Nix, YAML (in comments).

---

### Task 1: Preparation

- [ ] **Step 1: Verify git state**
Run: `git -C temp_mynixos status`
Expected: Check for clean working tree.

### Task 2: Inject Headers - Batch 1 (AI & Tools)

**Files:**
- Modify: `temp_mynixos/modules/apps/service-app-ai-agents.nix`
- Modify: `temp_mynixos/modules/apps/service-app-ai-tools.nix`
- Modify: `temp_mynixos/modules/apps/service-app-couchdb.nix`
- Modify: `temp_mynixos/modules/apps/service-app-filebrowser.nix`
- Modify: `temp_mynixos/modules/apps/service-app-karakeep.nix`

- [ ] **Step 1: Inject Header into service-app-ai-agents.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-TOOLS-AI-AGENTS
# title: Ai Agents (Ollama & Claude)
# capabilities: [ "ai", "gpu" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 2: Inject Header into service-app-ai-tools.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-TOOLS-AI-TOOLS
# title: AI Tools (SRE Assisted)
# capabilities: [ "ai", "shell" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 3: Inject Header into service-app-couchdb.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-TOOLS-COUCHDB
# title: CouchDB (Aviation-Grade)
# capabilities: [ "nosql", "database" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 4: Inject Header into service-app-filebrowser.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-TOOLS-FILEBROWSER
# title: Filebrowser (SRE Hardened)
# capabilities: [ "web-file-manager" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 5: Inject Header into service-app-karakeep.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-TOOLS-KARAKEEP
# title: Karakeep (Aviation-Grade)
# capabilities: [ "bookmarks", "web" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 6: Commit Batch 1**
Run: `git -C temp_mynixos add modules/apps/service-app-ai-*.nix modules/apps/service-app-couchdb.nix modules/apps/service-app-filebrowser.nix modules/apps/service-app-karakeep.nix && git -C temp_mynixos commit -m "docs: add NMS v2.3 metadata headers for AI and Tool apps"`

### Task 3: Inject Headers - Batch 2 (Automation & Security)

**Files:**
- Modify: `temp_mynixos/modules/apps/service-app-home-assistant.nix`
- Modify: `temp_mynixos/modules/apps/service-app-n8n.nix`
- Modify: `temp_mynixos/modules/apps/service-app-olivetin.nix`
- Modify: `temp_mynixos/modules/apps/service-app-semaphore.nix`
- Modify: `temp_mynixos/modules/apps/service-app-vaultwarden.nix`

- [ ] **Step 1: Inject Header into service-app-home-assistant.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-AUTOMATION-HASS
# title: Home Assistant (Aviation-Grade)
# capabilities: [ "home-automation", "iot" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 2: Inject Header into service-app-n8n.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-AUTOMATION-N8N
# title: n8n Workflow Automation (Aviation-Grade)
# capabilities: [ "workflow", "automation" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 3: Inject Header into service-app-olivetin.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-AUTOMATION-OLIVETIN
# title: OliveTin (SRE Exhausted)
# capabilities: [ "shell", "control-panel" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 4: Inject Header into service-app-semaphore.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-AUTOMATION-SEMAPHORE
# title: Semaphore
# capabilities: [ "ansible", "automation" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 5: Inject Header into service-app-vaultwarden.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-SECURITY-VAULTWARDEN
# title: Vaultwarden (SRE Exhausted)
# capabilities: [ "passwords", "security" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 6: Commit Batch 2**
Run: `git -C temp_mynixos add modules/apps/service-app-home-assistant.nix modules/apps/service-app-n8n.nix modules/apps/service-app-olivetin.nix modules/apps/service-app-semaphore.nix modules/apps/service-app-vaultwarden.nix && git -C temp_mynixos commit -m "docs: add NMS v2.3 metadata headers for Automation and Security apps"`

### Task 4: Inject Headers - Batch 3 (Social & Knowledge)

**Files:**
- Modify: `temp_mynixos/modules/apps/service-app-linkwarden.nix`
- Modify: `temp_mynixos/modules/apps/service-app-matrix-conduit.nix`
- Modify: `temp_mynixos/modules/apps/service-app-miniflux.nix`
- Modify: `temp_mynixos/modules/apps/service-app-monica.nix`
- Modify: `temp_mynixos/modules/apps/service-app-readeck.nix`
- Modify: `temp_mynixos/modules/apps/service-app-paperless.nix`

- [ ] **Step 1: Inject Header into service-app-linkwarden.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-SOCIAL-LINKWARDEN
# title: Linkwarden (SRE Hardened)
# capabilities: [ "bookmarks", "archive" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 2: Inject Header into service-app-matrix-conduit.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-SOCIAL-MATRIX
# title: Matrix Conduit
# capabilities: [ "communication", "matrix" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 3: Inject Header into service-app-miniflux.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-SOCIAL-MINIFLUX
# title: Miniflux (SRE Exhausted)
# capabilities: [ "rss", "news" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 4: Inject Header into service-app-monica.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-SOCIAL-MONICA
# title: Monica
# capabilities: [ "crm" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 5: Inject Header into service-app-readeck.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-SOCIAL-READECK
# title: Readeck (SRE Hardened)
# capabilities: [ "read-it-later", "web" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 6: Inject Header into service-app-paperless.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-TOOLS-PAPERLESS
# title: Paperless-ngx (Aviation-Grade)
# capabilities: [ "documents", "knowledge" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 7: Commit Batch 3**
Run: `git -C temp_mynixos add modules/apps/service-app-*.nix && git -C temp_mynixos commit -m "docs: add NMS v2.3 metadata headers for Social and Knowledge apps"`

### Task 5: Inject Headers - Batch 4 (Media Apps)

**Files:**
- Modify: `temp_mynixos/modules/apps/service-app-audiobookshelf.nix`
- Modify: `temp_mynixos/modules/apps/service-app-navidrome.nix`
- Modify: `temp_mynixos/modules/apps/service-app-seerr.nix`

- [ ] **Step 1: Inject Header into service-app-audiobookshelf.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-MEDIA-ABS
# title: Audiobookshelf (Aviation-Grade)
# capabilities: [ "audiobooks", "podcasts" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 2: Inject Header into service-app-navidrome.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-MEDIA-NAVIDROME
# title: Navidrome (Aviation-Grade Music Server)
# capabilities: [ "music", "streaming" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 3: Inject Header into service-app-seerr.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-MEDIA-SEERR
# title: Seerr (Aviation-Grade Requests)
# capabilities: [ "requests", "media" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 4: Commit Batch 4**
Run: `git -C temp_mynixos add modules/apps/service-app-audiobookshelf.nix modules/apps/service-app-navidrome.nix modules/apps/service-app-seerr.nix && git -C temp_mynixos commit -m "docs: add NMS v2.3 metadata headers for Media service-app modules"`

### Task 6: Inject Headers - Batch 5 (Media Servarr & Streaming)

**Files:**
- Modify: `temp_mynixos/modules/apps/service-media-jellyfin.nix`
- Modify: `temp_mynixos/modules/apps/service-media-jellyseerr.nix`
- Modify: `temp_mynixos/modules/apps/service-media-lidarr.nix`
- Modify: `temp_mynixos/modules/apps/service-media-prowlarr.nix`
- Modify: `temp_mynixos/modules/apps/service-media-radarr.nix`
- Modify: `temp_mynixos/modules/apps/service-media-readarr.nix`
- Modify: `temp_mynixos/modules/apps/service-media-sabnzbd.nix`
- Modify: `temp_mynixos/modules/apps/service-media-sonarr.nix`

- [ ] **Step 1: Inject Header into service-media-jellyfin.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-MEDIA-JELLYFIN
# title: Jellyfin (Aviation-Grade)
# capabilities: [ "media", "jellyfin", "gpu" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 2: Inject Header into service-media-jellyseerr.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-MEDIA-JELLYSEERR
# title: Jellyseerr
# capabilities: [ "media", "requests" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 3: Inject Header into service-media-lidarr.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-MEDIA-LIDARR
# title: Lidarr (Aviation-Grade)
# capabilities: [ "media", "music", "downloads" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 4: Inject Header into service-media-prowlarr.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-MEDIA-PROWLARR
# title: Prowlarr (Aviation-Grade)
# capabilities: [ "media", "indexer" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 5: Inject Header into service-media-radarr.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-MEDIA-RADARR
# title: Radarr (Aviation-Grade)
# capabilities: [ "media", "movies", "downloads" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 6: Inject Header into service-media-readarr.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-MEDIA-READARR
# title: Readarr (Aviation-Grade)
# capabilities: [ "media", "books", "downloads" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 7: Inject Header into service-media-sabnzbd.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-MEDIA-SABNZBD
# title: SABnzbd (Aviation-Grade)
# capabilities: [ "media", "usenet", "downloads" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 8: Inject Header into service-media-sonarr.nix**
Insert at line 1:
```nix
# ---
# nms_id: APP-MEDIA-SONARR
# title: Sonarr (Aviation-Grade)
# capabilities: [ "media", "tv", "downloads" ]
# status: "aviation-hardened"
# tier_strategy: "ABC-v5.1"
# ---
```

- [ ] **Step 9: Commit Batch 5**
Run: `git -C temp_mynixos add modules/apps/service-media-*.nix && git -C temp_mynixos commit -m "docs: add NMS v2.3 metadata headers for Media servarr modules"`

### Task 7: Verification

- [ ] **Step 1: Check a random file for header**
Run: `head -n 7 temp_mynixos/modules/apps/service-media-radarr.nix`
Expected: Header present.

- [ ] **Step 2: Ensure no double headers**
Run: `grep -c "---" temp_mynixos/modules/apps/service-media-radarr.nix`
Expected: 2 (start and end of header).

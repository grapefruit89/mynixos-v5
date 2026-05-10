# Hermes Agent Docker Setup Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Set up Hermes Agent and its Web UI on Windows using Docker Desktop with persistent storage.

**Architecture:** Multi-container setup using Docker Compose. A local folder on the Windows host is mapped into the container for persistence.

**Tech Stack:** Docker, Docker Desktop, Docker Compose, Hermes Agent (Nous Research), Hermes UI (Pyrate Llama).

---

### Task 1: Create Host Directory Structure

**Files:**
- Create: `C:\Users\morit\.hermes\data`
- Create: `C:\Users\morit\.hermes\ui-config`

- [ ] **Step 1: Create the base directory**

Run: `New-Item -ItemType Directory -Path "C:\Users\morit\.hermes" -Force`
Expected: Directory created.

- [ ] **Step 2: Create subdirectories for Agent and UI**

Run: `New-Item -ItemType Directory -Path "C:\Users\morit\.hermes\data", "C:\Users\morit\.hermes\ui-config" -Force`
Expected: Subdirectories created.

- [ ] **Step 3: Verify directory permissions**

Run: `Get-Item "C:\Users\morit\.hermes" | Format-List`
Expected: Current user has full control.

---

### Task 2: Create Docker Compose Configuration

**Files:**
- Create: `docker-compose.hermes.yml` (in current project directory)

- [ ] **Step 1: Write the docker-compose file**

```yaml
version: '3.8'

services:
  hermes-agent:
    image: nousresearch/hermes-agent:latest
    container_name: hermes-agent
    volumes:
      - C:\Users\morit\.hermes\data:/opt/data
    restart: unless-stopped
    stdin_open: true # needed for interactive setup
    tty: true

  hermes-ui:
    image: pyrate-llama/hermes-ui:latest
    container_name: hermes-ui
    ports:
      - "3000:3000"
    environment:
      - HERMES_AGENT_URL=http://hermes-agent:8080 # default internal port
    depends_on:
      - hermes-agent
    restart: unless-stopped
```

- [ ] **Step 2: Validate the compose file syntax**

Run: `docker compose -f docker-compose.hermes.yml config`
Expected: Validated YAML output.

---

### Task 3: Initialize and Setup Hermes Agent

**Files:**
- Modify: (Internal container state)

- [ ] **Step 1: Pull the images**

Run: `docker compose -f docker-compose.hermes.yml pull`
Expected: Images downloaded.

- [ ] **Step 2: Start the agent in setup mode**

Run: `docker run -it --rm -v C:\Users\morit\.hermes\data:/opt/data nousresearch/hermes-agent setup`
Expected: Interactive wizard starts. **Note:** User must provide API keys here.

- [ ] **Step 3: Start the full stack**

Run: `docker compose -f docker-compose.hermes.yml up -d`
Expected: Both containers start in the background.

---

### Task 4: Verification

**Files:**
- Test: Browse `http://localhost:3000`

- [ ] **Step 1: Check container logs for errors**

Run: `docker compose -f docker-compose.hermes.yml logs`
Expected: No fatal errors in logs.

- [ ] **Step 2: Verify UI accessibility**

Action: Open browser at `http://localhost:3000`.
Expected: Glassmorphic UI loads and connects to the agent.

- [ ] **Step 3: Run a health check via CLI**

Run: `docker exec -it hermes-agent hermes doctor`
Expected: All systems green.

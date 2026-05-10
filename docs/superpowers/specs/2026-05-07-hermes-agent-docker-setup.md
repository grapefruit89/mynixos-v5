# Spec: Hermes Agent Docker Setup on Windows

## Status
- **Date:** 2026-05-07
- **Topic:** Hermes Agent Installation
- **Platform:** Windows 11 with Docker Desktop
- **Status:** Approved

## Goals
- Install Hermes Agent (Core) and Hermes UI (Frontend) on Windows.
- Ensure persistent storage for memory, settings, and API keys.
- Provide an easy-to-use setup via Docker Compose.

## Architecture
We will use a multi-container Docker setup:
1.  **hermes-agent**: The brain of the operation.
    - Image: `nousresearch/hermes-agent`
    - Volume: `C:\Users\morit\.hermes\data:/opt/data`
2.  **hermes-ui**: The glassmorphic web interface.
    - Image: `pyrate-llama/hermes-ui`
    - Port: `3000:3000`
    - Dependencies: Depends on `hermes-agent`.

## Components

### 1. Persistent Storage
Folders to be created on the host:
- `C:\Users\morit\.hermes\data` (Agent state)
- `C:\Users\morit\.hermes\ui-config` (UI settings)

### 2. Docker Compose File
A `docker-compose.yml` will be created in the user's project directory or a dedicated folder.

### 3. Setup Wizard
The first step after starting the containers will be running the `hermes setup` command inside the agent container to configure providers (OpenAI, Anthropic, Ollama, etc.).

## Success Criteria
- `docker compose up -d` starts both services without errors.
- Hermes UI is accessible via `http://localhost:3000`.
- Settings persist after container restart.

## Future Integration
- Link with the local Ollama instance (from NixHome) if desired.
- Integration with the "Distiller" RAG pipeline.

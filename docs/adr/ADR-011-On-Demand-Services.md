---
title: ADR-011: On-Demand Service Orchestration (Socket Activation)
domain: 11
status: [SUPERSEDED]
category: architecture/decision
capabilities: [resource-efficiency, systemd-socket-activation, wake-on-request]
last_reviewed: 2026-05-18
nix_modules: []
sources: [Systemd Documentation, NixOS Manual, Caddy Documentation]
---

# 🏛️ ADR-011: On-Demand Services (Superseded)

## Status
Diese ADR wurde durch **ADR-012** ersetzt.

## Grund für Superseding
Der ursprüngliche Plan, kritische Dienste wie SSH via Socket-Activation zu betreiben, wurde aus Sicherheitsgründen (Lockout-Gefahr) verworfen. ADR-012 definiert nun präzisere Auswahlkriterien für die Socket-Activation.
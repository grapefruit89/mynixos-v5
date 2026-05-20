# Specification: Aviation-Grade Plus (Enrichment Phase 2)

This document outlines the requirements for the second phase of documentation enrichment, as defined by the "Aviation-Grade Plus" feedback.

## 🎯 Objectives
Elevate the current Guide collection from "High Quality" to "Industry-Leading Traceability" by adding structural depth, visual aids, and cross-references.

## 🛠️ Improvement Points (The 10 Commandments)

1.  **Explicit Anchor Linking**: In the guide text, explicitly refer to code anchors. 
    *   *Format:* "See `modules/...` (Anchor: `anchor-name`)"
2.  **ADR References**: Link guides to the "Why" behind decisions.
    *   *Action:* Add `adr: [ADR-001, ADR-002]` to YAML frontmatter.
    *   *Section:* Add a "Decision Log" or "ADR" section to each guide.
3.  **Code-Anchor Sync**: Ensure every module in `nix_modules` actually has the `# anchor:` tag in the code.
4.  **Upstream Context7**: Link to official Nixpkgs source for comparison.
    *   *Example:* `<!-- context7: nixpkgs/nixos/modules/services/networking/caddy.nix -->`
5.  **Standardized MCP Schema**: Use a consistent query syntax.
    *   *Example:* `<!-- mcp: show-file repo_v5/modules/... -->`
6.  **Parametrized Verification**: Refine commands to filter specific output (e.g., `nft list chain ...`) and add negative tests (`! curl ...`).
7.  **Troubleshooting Callouts**: Add "What if it fails?" boxes for common hardware/software pitfalls.
8.  **Mermaid Diagrams**: Visual flows for:
    *   Storage Tiering (Smart Mover)
    *   SSO Authentication (Pocket-ID Flow)
    *   Networking Zones
    *   Backup Pipelines
9.  **Technical Integrity & Flake Check**: Refer to `nix flake check` or technical integrity fields/checksums.
10. **Universal Source Registry**: Every guide must have a "Quellen & Verweise" section with external GitHub repositories.

## 🏛️ ADR Enrichment (The Decision Layer)

To ensure the "Why" is as traceable as the "How", all ADRs in `docs/adr/` must undergo the same enrichment process:

1.  **Bidirectional Linking**: 
    *   Add `guides: [guide-name.md]` to ADR frontmatter.
    *   Add `adr: [ADR-xxx]` to Guide frontmatter.
2.  **Context7 URL Upgrade**: Replace local `repo_v5/...` paths with full GitHub URLs or official `nixpkgs/...` paths.
3.  **Code-Anchor Verification**: Ensure every module referenced in an ADR has a corresponding `# anchor:` in the Nix source.
4.  **MCP Integration**: Add `<!-- mcp: nixos:repo_v5/... -->` tags for all referenced files.
5.  **Status Sync**: Update `last_reviewed` to reflect the latest audit.

## 🚀 Execution Strategy
1.  Apply these 10 points to each guide starting from `00-core-hardware.md`.
2.  Maintain a "Technical Integrity Checksum" for each guide to detect drift.
3.  Use Mermaid-as-Code directly in the markdown files.

---
**Status:** DRAFT (Ready for next session)

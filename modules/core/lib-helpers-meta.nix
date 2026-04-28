{ lib, ... }: {
  # 🚀 NMS v4.2 Traceability Schema
  # Erlaubt jedem Modul, Metadaten für das SRE-Audit zu exportieren.
  options.my.meta = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        id = lib.mkOption { 
          type = lib.types.str; 
          description = "Eindeutige ID (z.B. NIXH-60-APP-001)";
        };
        title = lib.mkOption { 
          type = lib.types.str; 
          description = "Anzeigename des Dienstes";
        };
        description = lib.mkOption {
          type = lib.types.str;
          default = "";
        };
        layer = lib.mkOption { 
          type = lib.types.int; 
          description = "Architektur-Layer (00-90)";
        };
        audit = {
          last_reviewed = lib.mkOption { 
            type = lib.types.str; 
            default = "2026-04-27";
            description = "Letztes Audit-Datum";
          };
          complexity = lib.mkOption {
            type = lib.types.int;
            default = 1;
            description = "Komplexitäts-Score (1-5)";
          };
        };
        source_repo = lib.mkOption {
          type = lib.types.str;
          default = "grapefruit89/mynixos";
          description = "Herkunfts-Repository (GitHub)";
        };
      };
    });
    default = {};
    description = "NMS Traceability Metadata Registry";
  };
}

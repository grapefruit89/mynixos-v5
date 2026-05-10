{ lib, ... }:
let
 nms = {
 id = "NIXH-01-SEC-FLAT-001";
 title = "Flat Layout Enforcement (Horizontal)";
 description = "Enforces zero-depth directory structure for modular silos.";
 layer = 90;
 nixpkgs.category = "system/policy";
 capabilities = [ "policy/enforcement" "architecture/integrity" ];
 audit.last_reviewed = "2026-04-27";
 audit.complexity = 2;
 };

 # Wir prüfen jetzt die horizontalen Silos auf unerwünschte Unterverzeichnisse
 layersToCheck = [
 ../core
 ../services
 ../apps
 ../security
 ];

 hasSubdirs = dir: 
 let
 # Wir müssen prüfen ob das Verzeichnis überhaupt existiert, 
 # da Nix builtins.readDir auf nicht existierende Pfade fehlschlägt.
 contents = if builtins.pathExists dir then builtins.readDir dir else {};
 dirs = lib.filterAttrs (n: v: v == "directory") contents;
 in
 (builtins.length (builtins.attrNames dirs)) > 0;

 offendingLayers = lib.filter (dir: hasSubdirs dir) layersToCheck;
in
{
 options.my.meta.flat_layout = lib.mkOption {
 type = lib.types.attrs;
 default = nms;
 readOnly = true;
 description = "NMS metadata";
 };

 config.warnings = lib.optional ((builtins.length offendingLayers) > 0)
    "🛑 NIXHOME HORIZONTAL VIOLATION: Subdirectories in modules/ silos are strictly forbidden! (hardened Rule)";
}
/**
 * ---\n * technical_integrity:\n * checksum: sha256:d13e9a7b9600bfbd98bc1057589bcf25b5b1b8aa890de35898f63eb3211fd04e2\n * eof_marker: NIXHOME_VALID_EOF* ---\n */

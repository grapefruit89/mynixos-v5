# ---NIXMETA
# {
#   "specVersion": "2.0",
#   "id": "NIXH-099-TOOL-002",
#   "title": "NIXMETA Dependency Graph Builder",
#   "layer": 90,
#   "category": "tooling/graph",
#   "lastReviewed": "2026-05-14",
#   "reviewedBy": "Gemini",
#   "status": "production",
#   "complexity": 3,
#   "tags": ["graph", "metadata", "nixmeta"],
#   "description": "Pure Nix expression to build a dependency graph and metric report from NIXMETA headers."
# }
# ---ENDNIXMETA
{ lib, root ? ./. }:
let
  inherit (builtins) readDir readFile fromJSON match hashString stringLength split;

  # Recursive file search for .nix files
  findNixFiles = dir:
    let
      contents = readDir dir;
      files = lib.mapAttrsToList (name: type:
        let path = "${dir}/${name}"; in
        if type == "directory" then findNixFiles path
        else if type == "regular" && lib.hasSuffix ".nix" name then [path]
        else []
      ) contents;
    in lib.flatten files;

  # Extract NIXMETA block from file
  extractMeta = path:
    let
      content = readFile path;
      # Match # ---NIXMETA \n (JSON) \n # ---ENDNIXMETA
      regex = ".*# ---NIXMETA\n((.|\n)*)\n# ---ENDNIXMETA.*";
      matched = match regex content;
      rawJson = if matched != null then lib.head matched else null;
      # Clean JSON (remove leading # and whitespace)
      cleanJson = if rawJson != null then 
        lib.concatStringsSep "\n" (lib.filter (s: s != "" && s != "\n") (lib.map (line: lib.removePrefix "# " (lib.trim line)) (lib.splitString "\n" rawJson)))
      else null;
    in if cleanJson != null then fromJSON cleanJson else null;

  # Compute metrics for a file
  getMetrics = path:
    let
      content = readFile path;
      lines = lib.length (lib.splitString "\n" content);
      size = stringLength content;
      sha256 = hashString "sha256" content;
    in {
      inherit lines size sha256;
    };

  allFiles = findNixFiles root;
  
  processedFiles = lib.map (path:
    let
      relPath = lib.removePrefix (toString root + "/") (toString path);
      meta = extractMeta path;
      metrics = getMetrics path;
    in {
      path = relPath;
      inherit meta metrics;
    }
  ) allFiles;

  # Filter out files without metadata
  filesWithMeta = lib.filter (f: f.meta != null) processedFiles;

  # Build the graph
  graph = {
    nodes = lib.map (f: {
      id = f.meta.id or f.path;
      inherit (f) path metrics;
      inherit (f.meta) title layer category status complexity tags;
    }) filesWithMeta;
    
    edges = lib.flatten (lib.map (f:
      if f.meta ? dependencies then
        lib.map (dep: {
          source = f.meta.id;
          target = dep;
        }) f.meta.dependencies
      else []
    ) filesWithMeta);
  };

in graph

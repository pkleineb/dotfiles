{ dir, ... }:
let
  # finds all entries in current dir
  entries = builtins.readDir dir;

  imports = builtins.attrValues(
    builtins.mapAttrs(name: type: # maps the keys to the values using the function specified
      if type == "directory" then "${dir}/${name}" else null
    )
    entries
  );

  valid_imports = builtins.filter(path: path != null) imports;
in
  valid_imports

{ lib, dir, ... }:

let
  get_dir = dir: lib.mapAttrs
    (file: type:
      if type == "directory" then get_dir "${dir}/${file}" else type
    )
    (builtins.readDir dir);

  files = dir:
    let
      dir_contents = get_dir dir;
      flattened_files = lib.collect lib.isString (lib.mapAttrsRecursive (path: type: lib.concatStringsSep "/" path) dir_contents);
    in
    flattened_files;

  valid_files = dir : 
    let
      all_files = files dir;
      filtered_files = lib.filter (file: lib.hasSuffix "default.nix" file) all_files;
      result = lib.map (file: "${dir}/${file}") filtered_files;
    in
      result;
in
  valid_files dir

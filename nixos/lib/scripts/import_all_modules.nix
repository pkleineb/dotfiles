{ lib, dir, ... }:

let
  get_dir = dir: lib.mapAttrs
    (file: type:
      if type == "directory" then get_dir "${dir}/${file}" else type
    )
    (builtins.readDir dir);

  files = dir: lib.collect lib.isString (lib.mapAttrsRecursive (path: type: lib.concatStringsSep "/" path) (get_dir dir));

  valid_files = dir : lib.map
    (file : dir + "/${file}")
    (lib.filter
      (file: lib.hasSuffix ".nix" file)
      (files dir)
    );
in
  valid_files dir

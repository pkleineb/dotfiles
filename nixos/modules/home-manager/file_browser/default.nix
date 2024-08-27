{ pkgs, inputs, config, lib, ... }: 
let
  import_dirs = inputs.self.outputs.scripts.import_all_modules;
in
{
  imports = import_dirs { dir=./.; };
}

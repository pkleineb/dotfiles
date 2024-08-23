{ pkgs, inputs, ... }: 
let
  import_dirs = inputs.self.outputs.scripts.import_all_modules;
in
{
  imports = import_dirs { dir=./.; };

  fonts.fontconfig.enable = true;
}

{ ... }:

{
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    enableOnBoot = false;
  };
}

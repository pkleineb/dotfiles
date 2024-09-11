{ pkgs, config, lib, ... }: 

{
  imports = import_dirs { dir=./.; };

  config.lib.meta = {
    # my home manager module dir this although not being a fully absolute path needs us to use
    # --impure when rebuilding
    # I am not quite sure how I should change this so lets leave it at this for now and accept
    # the impure rebuild
    home_manager_module_dir = "${config.home.homeDirectory}/dotfiles/nixos/modules/home-manager";

    # maps out the given dir and its sub dirs recursively into a hashmap
    map_directory = dir:
      let
        entries = builtins.readDir dir;

        # defining function that recursively constructs hashmap
        process_entry = name: type:
          if type == "directory"
          then { ${name} = config.lib.meta.map_directory "${dir}/${name}"; }
          else { ${name} = {}; };

        # mapping hashmap construction function over all entries in current dir
        entry_maps = lib.mapAttrs process_entry entries;
      in
        # stitching together the hashmaps
        lib.foldr lib.recursiveUpdate {} (builtins.attrValues entry_maps);

    # we define this here so we only have to loop over the home manager module dir once
    # and not every invocation of mk_out_of_store_symlink or find_deepest_occurance
    directory_map = config.lib.meta.map_directory config.lib.meta.home_manager_module_dir;

    find_deepest_occurance = base_name:
      let
        search = path: map:
          # if the maps level has the attribute of base_name we need to check it's sub directories
          # if the name occures in these ones as well
          if builtins.hasAttr base_name map
          then
            # if a deeper occurence is found so deeper != null then we will return that path if it
            # is not found we go with our current find
            let deeper = search (path + "/${base_name}") map.${base_name};
            in if deeper != null then deeper else path + "/${base_name}"
          else
            let
              # if the name we are looking for is not in the current level of the hashmap we search through
              # every dir of the hashmap to find an occurence
              sub_results = lib.mapAttrsToList (name: value: search (path + "/${name}") value) map;
              valid_results = builtins.filter (x: x != null) sub_results;
            in
              # bultins.head returns the first element of valid_resutls since it should only ever have one
              # or zero elements
              if valid_results != [] then builtins.head valid_results else null;
      in
        search "" config.lib.meta.directory_map;

    mk_out_of_store_symlink = path:
      let
        base_name = builtins.baseNameOf path;

        relative_config_path = config.lib.meta.find_deepest_occurance base_name;
      in
        config.lib.file.mkOutOfStoreSymlink (config.lib.meta.home_manager_module_dir + relative_config_path);
  };
}

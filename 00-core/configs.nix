{ lib, ... }: {
  options.my.configs = {
    identity = {
      domain = lib.mkOption { 
        type = lib.types.str; 
        default = "m7c5.de"; 
        description = "Global base domain";
      };
      subdomain = lib.mkOption { 
        type = lib.types.str; 
        default = "nix"; 
        description = "NixOS specific subdomain";
      };
      user = lib.mkOption {
        type = lib.types.str;
        default = "moritz";
        description = "Primary system administrator user";
      };
    };
    
    network = {
      lanIP = lib.mkOption { 
        type = lib.types.str; 
        default = "192.168.2.73"; 
        description = "Primary LAN IP of the Fujitsu Q958";
      };
      lanCidr = lib.mkOption {
        type = lib.types.str;
        default = "192.168.2.0/24";
        description = "Trusted local network range";
      };
    };
  };
}

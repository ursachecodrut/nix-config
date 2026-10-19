{ pkgs, ... }:

{
  programs.brave = {
    enable = true;
    nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "gppongmhjkpfnbhagpmjfkannfbllamg"; } # Wappalyzer
      { id = "cimiefiiaegbelhefglklhhakcgmhkai"; } # Plasma Integration
    ];
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:

let
  store = config.signal.passwordStore;
in
{
  options.signal.passwordStore = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    example = "kwallet6";
    description = ''
      Keyring backend Signal keeps its database key in. Electron guesses it from
      the desktop, which breaks when one key is used across sessions (e.g. a key
      stored in KWallet under Plasma, then read under niri).
    '';
  };

  config.home.packages = [
    (
      if store == null then
        pkgs.signal-desktop
      else
        pkgs.symlinkJoin {
          name = "signal-desktop";
          paths = [ pkgs.signal-desktop ];
          nativeBuildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/signal-desktop --add-flags "--password-store=${store}"
          '';
        }
    )
  ];
}

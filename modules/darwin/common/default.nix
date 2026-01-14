{
  outputs,
  pkgs,
  userConfig,
  ...
}:
{
  # Nixpkgs configuration
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Nix settings
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    optimise.automatic = true;
    package = pkgs.nix;
  };

  # User configuration
  users.users.${userConfig.name} = {
    name = "${userConfig.name}";
    home = "/Users/${userConfig.name}";
  };

  # System settings
  system = {
    defaults = {
      controlcenter = {
        BatteryShowPercentage = true;
        NowPlaying = false;
      };
      CustomUserPreferences = {
        "com.apple.symbolichotkeys" = {
            AppleSymbolicHotKeys = {
            "60" = {
                # Disable '^ + Space' for selecting the previous input source
                enabled = false;
            };
            "61" = {
                # Disable '^ + Option + Space' for selecting the next input source
                enabled = false;
            };
            # Disable 'Cmd + Space' for Spotlight Search
            "64" = {
                enabled = false;
            };
            # Disable 'Cmd + Alt + Space' for Finder search window
            "65" = {
                # Set to false to disable
                enabled = true;
            };
            };
        };
      };
      NSGlobalDomain = {
        "com.apple.sound.beep.volume" = 0.000;
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;             
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 12;
        KeyRepeat = 1;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
      };
      LaunchServices = {
        LSQuarantine = false;                          # Disable "Are you sure you want to open this application?" dialog
      };
      trackpad = {
        TrackpadThreeFingerDrag = true;
      };
      finder = {
        AppleShowAllFiles = true;
        FXDefaultSearchScope = "SCcf";                 # Search the current folder by default
        FXEnableExtensionChangeWarning = false;        # Disable extension change warning
        FXPreferredViewStyle = "Nlsv";                 # List view
        QuitMenuItem = true ;                          # Enable quitting Finder
        ShowPathbar = true;                            # Show path bar
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirst = true;
      };
      dock = {
        expose-animation-duration = 0.15;
        show-recents = false;
        showhidden = true;
        persistent-apps = [
            "/Users/${userConfig.name}/Applications/Home Manager Apps/WezTerm.app"
            "/Applications/Firefox.app"
            "/Applications/Microsoft Outlook.app"
            "/Applications/Slack.app"
            "/Applications/Discord.app"
            "/Applications/zoom.us.app"
            "/Applications/Visual Studio Code.app"
            "/Applications/Docker.app"
            "/Applications/Bitwarden.app"
            "/System/Applications/System Settings.app"
        ];
        tilesize = 50;
      };
      screencapture = {
        location = "/Users/${userConfig.name}/Downloads/Screenshots";
        type = "png";
        disable-shadow = true;
      };
    };
    primaryUser = "${userConfig.name}";
  };

  # Zsh configuration
  programs.zsh.enable = true;

  # Fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
  ];
}

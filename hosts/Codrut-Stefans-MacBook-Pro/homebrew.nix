{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true;    # Upgrade outdated casks, formulae, and App Store apps
      cleanup = "zap";   # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
    };

    # taps = [];

    # `brew install`
    # brews = [];

    casks = [
      "raycast" 
      "firefox"
      "slack"
      "zoom"
      "discord"
      "visual-studio-code"
      "bruno"
      "appcleaner"
      "bitwarden"
    ];
  };
}

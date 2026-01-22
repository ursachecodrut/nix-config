{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true;    # Upgrade outdated casks, formulae, and App Store apps
      cleanup = "zap";   # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
    };

    taps = [
      "nikitabobko/tap"
      "withgraphite/tap"
    ];

    # `brew install`
    brews = [
      "withgraphite/tap/graphite"
    ];

    casks = [
      "tailscale-app"
      "iterm2"
      "raycast" 
      "firefox"
      "slack"
      "zoom"
      "discord"
      "linear-linear"
      "visual-studio-code"
      "bruno"
      "appcleaner"
      "bitwarden"
      "aldente"
      "nikitabobko/tap/aerospace"
    ];
  };
}

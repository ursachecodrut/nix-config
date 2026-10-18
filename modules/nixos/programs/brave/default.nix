{
  # Brave reads enterprise policies from /etc/brave/policies/managed.
  # Verify what was loaded at brave://policy.
  environment.etc."brave/policies/managed/policies.json".text = builtins.toJSON {
    DefaultSearchProviderEnabled = true;
    DefaultSearchProviderName = "DuckDuckGo";
    DefaultSearchProviderKeyword = "ddg";
    DefaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
    DefaultSearchProviderSuggestURL = "https://duckduckgo.com/ac/?q={searchTerms}&type=list";

    BraveAIChatEnabled = false;
    BraveWalletDisabled = true;
    BraveRewardsDisabled = true;
  };
}

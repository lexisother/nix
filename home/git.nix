{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Alyxia Sother";
    userEmail = "alyxia@riseup.net";
    signing = {
      key = "01E16C4E775A37E4";
      signByDefault = true;
    };

    delta = {
      enable = true;
      options = {
        line-numbers = true;
        features = "decorations";
        syntax-theme = "ansi";
      };
    };

    extraConfig = {
      tag.gpgsign = true;
      init.defaultBranch = "master";
    };
  };
}

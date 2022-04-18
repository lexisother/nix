{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Alyxia Sother";
    userEmail = "alyxia@riseup.net";

    delta = {
      enable = true;
      options = {
        line-numbers = true;
        features = "decorations";
        syntax-theme = "ansi";
      };
    };

    extraConfig = {
      init.defaultBranch = "master";
    };
  };
}

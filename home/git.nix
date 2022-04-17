{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Alyxia Sother";
    userEmail = "alyxia@riseup.net";

    extraConfig = {
      init.defaultBranch = "master";
    };
  };
}

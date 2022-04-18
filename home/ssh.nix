{ ... }:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      git-a = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/ssh-ids/id_rsa-alyx";
      };
    };
  };
}

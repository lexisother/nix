{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped.overrideAttrs (prev: rec {
      version = "0.6.1";

      src = pkgs.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "5b839ced692230fe582fde41f79f875ee90451e8";
        sha256 = "sha256-0XCW047WopPr3pRTy9rF3Ff6MvNRHT4FletzOERD41A=";
      };
    });

    extraConfig = "source ~/.dotfiles/nvim/init.vim";
  };
}

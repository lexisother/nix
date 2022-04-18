{ pkgs, dotfiles, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped.overrideAttrs (prev: rec {
      version = "0.7.0";

      src = pkgs.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "333ba6569d833e22c0d291547d740d4bbfa3fdab";
        sha256 = "sha256-eYYaHpfSaYYrLkcD81Y4rsAMYDP1IJ7fLJJepkACkA8=";
      };
    });

    # Symlink `vi` and `vim` to `nvim`
    viAlias = true;
    vimAlias = true;

    extraConfig = "source ${dotfiles}/nvim/init.vim";

    coc = {
      enable = true;

      settings = {
        languageserver = {
          nix = {
            command = "rnix-lsp";
            filetypes = [
              "nix"
            ];
          };
        };
        "go.goPlsOptions" = {
          completion = true;
          completeUnimported = true;
        };
      };
    };
  };
}

{ dotfiles, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = ''
      source ${dotfiles}/zsh/zshrc
    '';
  };
}

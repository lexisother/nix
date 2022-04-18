{ dotfiles, ... }:

{
  programs.zsh = {
    enable = true;
    initExtra = ''
      export GPG_TTY=$(tty)
      source ${dotfiles}/zsh/zshrc
    '';
  };
}

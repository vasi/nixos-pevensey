{ pkgs, myPkgs, ... }:
{
  programs = {
    firefox.enable = true;
    git.enable = true;
    zsh.enable = true;
    ydotool.enable = true;
    direnv.enable = true;
    steam.enable = true;
  };
  environment.systemPackages =
    with pkgs;
    with myPkgs;
    [
      # CLI
      file
      rclone
      ripgrep
      ncdu
      pixz
      pv
      killall
      lzopfs

      # Net
      google-chrome
      signal-desktop
      zoom-us
      vlc
      qbittorrent
      pocket-casts

      # Dev
      kdePackages.kate
      vscode-fhs
      nixd
      nixfmt-rfc-style
      jetbrains.idea-ultimate
      cntr

      # Misc
      libreoffice
      kdePackages.filelight
      deja-dup
    ];
}

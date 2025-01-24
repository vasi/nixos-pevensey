{ ... }:
{
  home.sessionVariables = {
    PATH = "$HOME/bin:$PATH";
  };
  programs = {
    git = {
      enable = true;
      userName = "Dave Vasilevsky";
      userEmail = "dave@vasilevsky.ca";
      aliases = {
        co = "checkout";
        st = "status";
        ci = "commit";
      };
      extraConfig.init.defaultBranch = "main";
    };
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "z"
          "command-not-found"
        ];
      };
      initExtra = builtins.readFile ./files/zshrc;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

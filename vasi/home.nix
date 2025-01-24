{ ... }:
{
  programs.git = {
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
}

{ ... }:
{
  programs.plasma = {
    enable = true;

    panels = [
      {
        location = "left";
        widgets = [
          { kickoff.icon = "nix-snowflake"; }
          { iconTasks = { }; }
          { systemTray = { }; }
          { digitalClock = { }; }
        ];
      }
    ];
  };
}

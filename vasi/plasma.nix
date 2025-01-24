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

    input.touchpads = [
      {
        name = "SYNA2393:00 06CB:7A13 Touchpad";
        vendorId = "06cb";
        productId = "7a13";
        naturalScroll = true;
        rightClickMethod = "twoFingers";
      }
    ];
  };
}

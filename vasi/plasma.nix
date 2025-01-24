{ pkgs, ... }:
let
  wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Flow";
in
{
  programs = {
    plasma = {
      enable = true;

      workspace.theme = "breeze-dark";

      panels = [
        {
          location = "left";
          screen = "all";
          widgets = [
            { kickoff.icon = "nix-snowflake"; }
            {
              iconTasks.launchers = [
                "applications:org.kde.dolphin.desktop"
                "applications:firefox.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:code.desktop"
              ];
            }
            { systemTray.items.shown = [ "org.kde.plasma.bluetooth" ]; }
            {
              digitalClock = {
                time.format = "24h";
                date.enable = false;
              };
            }
          ];
        }
      ];

      workspace.wallpaper = wallpaper;
      kscreenlocker.appearance.wallpaper = wallpaper;

      input.touchpads = [
        {
          name = "SYNA2393:00 06CB:7A13 Touchpad";
          vendorId = "06cb";
          productId = "7a13";
          naturalScroll = true;
          rightClickMethod = "twoFingers";
        }
      ];
      shortcuts.kwin."Window Maximize" = "Meta+Up";
      hotkeys.commands.emote = {
        name = "Launch Emote";
        key = "Meta+E";
        command = "emote";
      };

      powerdevil = {
        AC.whenSleepingEnter = "standbyThenHibernate";
        battery.whenSleepingEnter = "standbyThenHibernate";
        lowBattery.whenSleepingEnter = "standbyThenHibernate";

        AC.autoSuspend.action = "nothing";
        AC.turnOffDisplay.idleTimeout = 1800;
        battery.displayBrightness = 70;
        batteryLevels.criticalAction = "hibernate";
      };
    };

    konsole = {
      enable = true;
      defaultProfile = "vasi";
      profiles.vasi.extraConfig.Scrolling.HistoryMode = 2;
    };

    kate = {
      enable = true;
      editor.indent.width = 2;
    };
  };
}

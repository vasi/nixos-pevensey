{ pkgs, ... }:
let
  wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/Flow";
in
{
  programs.plasma = {
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

    shortcuts.kwin."Window Maximize" = "Meta+Up";

    configFile = {
      baloofilerc.General."exclude folders" = {
        value = "$HOME/gdrive/";
        shellExpand = true;
      };
      klaunchrc = {
        # No bouncy cursor
        BusyCursorSettings.Bouncing = false;
        FeedbackStyle.BusyCursor = false;
        TaskbarButtonSettings.Timeout = 2;
      };
      klipperrc.General.MaxClipItems = 100;
      krunnerrc.Plugins = {
        browserhistoryEnabled = false;
        krunner_bookmarksrunnerEnabled = false;
      };
      ktrashrc."\\/home\\/vasi\\/.local\\/share\\/Trash" = {
        UseTimeLimit = true;
        Days = 14;
      };
      kwinrc."Effect-overview".BorderActivate = 9; # No hot corner
      plasmanotifyrc.Notifications.PopupPosition = "TopRight";
      plasmaparc.General.AudioFeedback = false;
    };
  };
}

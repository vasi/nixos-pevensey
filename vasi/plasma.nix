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

      configFile = {
        baloofilerc.General."exclude folders" = {
          value = "$HOME/gdrive/";
          shellExpand = true;
        };
        dolphinrc = {
          ContentDisplay.DirectorySizeMode = "ContentSize";
          General.BrowseThroughArchives = true;
          General.ShowSelectionToggle = false;
        };
        katerc.General = {
          "Startup Session" = "last";
          "Show welcome view for new window" = false;
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
        kxkbrc.Layout = {
          Options = "compose:ralt";
          ResetOldOptions = true; # Necessary for other settings to work
        };
      };
      dataFile."dolphin/view_properties/global/.directory".Dolphin.SortFoldersFirst = false;
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

  home.sessionVariables = {
    SSH_ASKPASS = "${pkgs.ksshaskpass}/bin/ksshaskpass";
    GIT_ASKPASS = "${pkgs.ksshaskpass}/bin/ksshaskpass";
    SSH_ASKPASS_REQUIRE = "prefer";
  };
}

{ pkgs, ... }:
{
  imports = [
    ./plasma-hardware.nix
    ./plasma-desktop.nix
  ];

  programs.plasma.enable = true;

  # Dolphin
  programs.plasma.configFile.dolphinrc = {
    ContentDisplay.DirectorySizeMode = "ContentSize";
    General.BrowseThroughArchives = true;
    General.ShowSelectionToggle = false;
  };
  programs.plasma.dataFile."dolphin/view_properties/global/.directory".Dolphin.SortFoldersFirst =
    false;

  # Kate
  programs.kate = {
    enable = true;
    editor.indent.width = 2;
  };
  programs.plasma.configFile.katerc.General = {
    "Startup Session" = "last";
    "Show welcome view for new window" = false;
  };

  # Konsole
  programs.konsole = {
    enable = true;
    defaultProfile = "vasi";
    profiles.vasi.extraConfig.Scrolling.HistoryMode = 2;
  };

  # Emote
  programs.plasma.hotkeys.commands.emote = {
    name = "Launch Emote";
    key = "Meta+E";
    command = "emote";
  };

  # ksshaskpass
  home.sessionVariables = {
    SSH_ASKPASS = "${pkgs.ksshaskpass}/bin/ksshaskpass";
    GIT_ASKPASS = "${pkgs.ksshaskpass}/bin/ksshaskpass";
    SSH_ASKPASS_REQUIRE = "prefer";
  };
}

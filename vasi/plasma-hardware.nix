{
  programs.plasma = {
    input.touchpads = [
      {
        name = "SYNA2393:00 06CB:7A13 Touchpad";
        vendorId = "06cb";
        productId = "7a13";
        naturalScroll = true;
        rightClickMethod = "twoFingers";
      }
    ];

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
      kxkbrc.Layout = {
        Options = "compose:ralt";
        ResetOldOptions = true; # Necessary for options to work
      };
    };
  };
}

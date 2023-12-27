{pkgs, ...}: {
  time.timeZone = "Europe/Paris";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-chinese-addons
    fcitx5-table-extra
    fcitx5-chewing
  ];
  i18n.inputMethod.fcitx5.ignoreUserConfig = true;

  i18n.inputMethod.fcitx5.settings.inputMethod = {
    "Groups/0" = {
      "Name" = "gCangjie";
      "Default Layout" = "us";
      "DefaultIM" = "cangjie5";
    };
    "Groups/0/Items/0" = {
      "Name" = "cangjie5";
      "Layout" = null;
    };

    "Groups/1" = {
      "Name" = "gDvorak";
      "Default Layout" = "myDvorak";
      "DefaultIM" = "keyboard-myDvorak";
    };
    "Groups/1/Items/0" = {
      "Name" = "keyboard-myDvorak";
      "Layout" = null;
    };

    "Groups/2" = {
      "Name" = "gDvorakFrench";
      "Default Layout" = "myDvorakFrench";
      "DefaultIM" = "keyboard-myDvorakFrench";
    };
    "Groups/2/Items/0" = {
      "Name" = "keyboard-myDvorakFrench";
      "Layout" = null;
    };

    "GroupOrder" = {
      "0" = "gDvorak";
      "1" = "gDvorakFrench";
      "2" = "gCangjie";
    };
  };
  i18n.inputMethod.fcitx5.settings.globalOptions = {
    Hotkey = {
      EnumerateWithTriggerKeys = true;
      EnumerateForwardKeys = null;
      EnumerateBackwardKeys = null;
      EnumerateSkipFirst = null;
    };

    "Hotkey/TriggerKeys" = {};
    "Hotkey/AltTriggerKeys" = {"0" = "Shift_L";};
    "Hotkey/EnumerateGroupForwardKeys" = {"0" = "Control+space";};
    "Hotkey/EnumerateGroupBackwardKeys" = {};

    "Hotkey/PrevPage" = {"0" = "Up";};
    "Hotkey/NextPage" = {"0" = "Down";};
    "Hotkey/PrevCandidate" = {"0" = "Shift+Tab";};
    "Hotkey/NextCandidate" = {"0" = "Tab";};

    Behavior = {
      ActiveByDefault = false;
      ShareInputState = "No";
      PreeditEnabledByDefault = true;
      ShowInputMethodInformation = true;
      ShowInputMethodInformationWhenFocusIn = false;
      CompactInputmethodInformation = true;
      ShowFirstInputMethodInformation = true;
      DefaultPageSize = "5";
      OverriedXkbOption = false;
      CustomXkbOption = null;
      EnabledAddons = null;
      DisabledAddons = null;
      PreloadInputMethod = true;
      AllowInputMethodForPassword = false;
      ShowPreeditForPassword = false;
      AutoSavePeriod = "30";
    };
  };
}

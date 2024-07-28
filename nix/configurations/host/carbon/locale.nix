{ pkgs, ... }:

{
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = [
    pkgs.fcitx5-chinese-addons
    pkgs.fcitx5-table-extra
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

    "Hotkey/TriggerKeys" = { };
    "Hotkey/AltTriggerKeys" = {
      "0" = "Shift_L";
    };
    "Hotkey/EnumerateGroupForwardKeys" = {
      "0" = "Control+space";
    };
    "Hotkey/EnumerateGroupBackwardKeys" = {
      "0" = "Control+Shift+space";
    };

    "Hotkey/PrevPage" = {
      "0" = "Up";
    };
    "Hotkey/NextPage" = {
      "0" = "Down";
    };
    "Hotkey/PrevCandidate" = {
      "0" = "Shift+Tab";
    };
    "Hotkey/NextCandidate" = {
      "0" = "Tab";
    };

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

  i18n.inputMethod.fcitx5.settings.addons = {
    classicui.globalSection = {
      "Vertical Candidate List" = false;
      WheelForPaging = true;
      Font = "HanaMinB 12";
      MenuFont = "HanaMinB 12";
      TrayFont = "HanaMinB 12";
      PreferTextIcon = false;
      ShowLayoutNameInIcon = true;
      UseInputMethodLanguageToDisplayText = true;
      Theme = "default";
      DarkTheme = "default-dark";
      UseDarkTheme = false;
      UseAccentColor = true;
      PerScreenDPI = false;
    };
  };
}

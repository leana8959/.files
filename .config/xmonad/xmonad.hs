{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}

import XMonad
import XMonad.Core

import XMonad.Actions.PerWindowKeys

import XMonad.Util.EZConfig (additionalKeys, removeKeys)
import XMonad.Util.Paste
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab
import XMonad.Util.NamedScratchpad

import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.ManageHook

import Graphics.X11.ExtraTypes.XF86

import qualified XMonad.StackSet as W

import NeatInterpolation
import qualified Data.Text as T

xmonadConfig = def
  { modMask            = myMod
  , terminal           = myTerm
  , focusFollowsMouse  = True
  , borderWidth        = 5
  , workspaces         = myWorkspaces
  , manageHook         = namedScratchpadManageHook scratchpads <+> myManageHook
  , layoutHook         = myLayoutHook
  , startupHook        = myStartupHook
  , normalBorderColor  = "#18005f"
  , focusedBorderColor = "#875fff"
  }
  `removeKeys`     myUnmaps
  `additionalKeys` myKeymaps

myTerm = "kitty"

myMod = mod4Mask

myWorkspaces = ["H", "T", "N", "S"]

myLayoutHook =
  let nmaster  = 1
      ratio    = 1/2
      delta    = 3/100
      mag      = magnifiercz' 1.3
      tall     = Tall nmaster delta ratio
      threeCol = ThreeColMid nmaster delta ratio
  in  lessBorders OnlyScreenFloat -- hide border in full screen
      $ spacingWithEdge 5
      $ tall ||| Full ||| Mirror tall ||| (mag $ tall ||| threeCol)

myManageHook = composeAll
  [ className =? ".blueman-manager-wrapped"    --> doFloat
  , className =? "Eog"                         --> doFloat
  , className =? "Org.gnome.NautilusPreviewer" --> doFloat
  , className =? "Org.gnome.Nautilus"          --> doFloat
  , className =? "Evince"                      --> doFloat
  , title     =? "easyeffects"                 --> doFloat
  , title     =? "Picture-in-Picture"          --> doFloat
  , className =? "Element"                     --> doShift (myWorkspaces !! 1)
  , className =? "discord"                     --> doShift (myWorkspaces !! 1)
  , className =? "thunderbird"                 --> doShift (myWorkspaces !! 1)
  ]

scratchpads =
  [ NS "cmus"
      (myTerm ++ " -T 'cmus' cmus")
      (title =? "cmus")
      (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
  , NS "btop"
      (myTerm ++ " -T 'btop' btop")
      (title =? "btop")
      (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
  , NS "bitwarden"
      ("bitwarden")
      (className =? "Bitwarden")
      (customFloating $ W.RationalRect (1/2) (1/6) (2/5) (2/3))
  ]

-- Only remove mappings that needs pass through.
-- If a new mapping is added, the old one is overridden
myUnmaps =
  [ (myMod, xK_h)
  , (myMod, xK_l)
  ]
  ++ [ ((myMod              , n)) | n <- [xK_1 .. xK_9] ]
  ++ [ ((myMod .|. shiftMask, n)) | n <- [xK_1 .. xK_9] ]

myKeymaps =
  let remapWithFallback src dst =
        let fallback = [ (pure True, uncurry sendKey src) ]
        in  (src, bindFirst . (++fallback) $ dst)
  in  [ -- programs
        ((controlMask .|. myMod, xK_f), spawn "firefox")
      , ((controlMask .|. myMod, xK_m), namedScratchpadAction scratchpads "cmus")
      , ((controlMask .|. myMod, xK_p), namedScratchpadAction scratchpads "bitwarden")
      , ((controlMask .|. myMod, xK_h), namedScratchpadAction scratchpads "btop")

      -- screenshot
      , ( (mod4Mask .|. shiftMask, xK_3)
        , spawn "scrot -F - | xclip -in -selection clipboard -t image/png"
        )
      , ( (mod4Mask .|. shiftMask, xK_4)
        , spawn "scrot -s -F - | xclip -in -selection clipboard -t image/png"
        )
      , ( (controlMask .|. mod4Mask .|. shiftMask, xK_4)
        , spawn "scrot -s"
        )

      -- toggle external display
      , ((0, xF86XK_Display), spawn setupMonitors)

      , ((0, xF86XK_MonBrightnessDown), spawn "light -U 5")
      , ((0, xF86XK_MonBrightnessUp), spawn "light -A 5")

      -- volume adjustments
      , ((0, xF86XK_AudioMute), spawn "amixer set Master toggle")
      , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 5%-")
      , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+")

      -- playback control
      , ((0, xF86XK_AudioPrev), spawn "playerctl previous")
      , ((0, xF86XK_AudioPlay), spawn "playerctl play-pause")
      , ((0, xF86XK_AudioNext), spawn "playerctl next")

      -- Begin / End
      , ((mod4Mask, xK_Left), sendKey 0 xK_Home)
      , ((mod4Mask, xK_Right), sendKey 0 xK_End)

      -- Delete
      , ((mod4Mask, xK_BackSpace), sendKey 0 xK_Delete)

      -- screensaver / suspend
      , ( (controlMask .|. mod1Mask, xK_l)
        , spawn "xscreensaver-command -lock"
        )
      , ( (controlMask .|. mod1Mask, xK_z)
        , spawn "xscreensaver-command -lock ; systemctl suspend"
        )
      , ( (shiftMask .|. controlMask .|. mod1Mask, xK_z)
        , spawn "xscreensaver-command -lock ; systemctl hibernate"
        )

      -- tab navigation in firefox
      , remapWithFallback
        (controlMask .|. shiftMask, xK_bracketright)
        [ (className =? "firefox", sendKey controlMask xK_Tab) ]
      , remapWithFallback
        (controlMask .|. shiftMask, xK_bracketleft)
        [ (className =? "firefox", sendKey (controlMask .|. shiftMask) xK_Tab) ]

      -- resize windows
      , ((myMod .|. shiftMask, xK_comma) , sendMessage Shrink)
      , ((myMod .|. shiftMask, xK_period), sendMessage Expand)

      -- force back to tiling
      , ((myMod .|. shiftMask, xK_t), withFocused $ windows . W.sink)
     ]

     -- organic window jumping
     ++ [ ((myMod, n), windows $ W.greedyView space)
          | (n, space) <- zip [xK_h, xK_t, xK_n, xK_s] myWorkspaces
     ]

     -- organic window yeeting
     ++ [ ((myMod .|. mod1Mask, n), windows $ W.shift space)
          | (n, space) <- zip [xK_h, xK_t, xK_n, xK_s] myWorkspaces

     ]

myPrettyPrinter =
  filterOutWsPP [scratchpadWorkspaceTag]
  $ def
  { ppCurrent         = xmobarColor "#000000" "#ffffff"
  , ppHiddenNoWindows = xmobarColor "#a9a9a9" ""
  , ppSep             = " ⋅ "
  }

setupMonitors = T.unpack
  [text|
  if xrandr --output DP-1 --left-of eDP-1 --mode 2560x1440 --rate 59.94; then
      xrandr --output eDP-1 --off
  else
      xrandr --auto
  fi
  feh --bg-fill .wallpapers/haskell-pattern.png
  |]

setupXmobar = T.unpack
  [text|
  xmobar -x 0 ~/.config/xmobar/xmobarrc
  xmobar -x 1 ~/.config/xmobar/xmobarrc
  |]

myStartupHook = do
  spawnOnce setupMonitors                                      -- External display hack
  spawnOnce "pgrep fcitx5       || fcitx5 &"                   -- Input method
  spawnOnce "pgrep xscreensaver || xscreensaver --no-splash &" -- Screensaver
  spawnOnce "pgrep playerctld   || playerctld daemon"          -- Player controller
  spawnOnce "pgrep wired        || wired &"                    -- Notification daemon

  -- launch some useful softwares
  -- spawnOnce "element-desktop &"
  -- spawnOnce "discord &"
  -- spawnOnce "thunderbird &"

main = xmonad
      . ewmhFullscreen . ewmh
      . withEasySB
        (statusBarProp setupXmobar (pure myPrettyPrinter))
        defToggleStrutsKey
      $ xmonadConfig

-- vim:et:sw=2:ts=2

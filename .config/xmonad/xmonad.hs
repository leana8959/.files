{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}

import XMonad
import XMonad.Core

import XMonad.Actions.PerWindowKeys

import XMonad.Util.EZConfig (additionalKeys, removeKeys)
import XMonad.Util.Paste
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab

import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
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
  , borderWidth        = 2
  , workspaces         = myWorkspaces
  , manageHook         = myManageHook
  , layoutHook         = myLayoutHook
  , startupHook        = myStartupHook
  , normalBorderColor  = "#2a00a6"
  , focusedBorderColor = "#875fff"
  }
  `removeKeys`     myUnmaps
  `additionalKeys` myKeymaps

myTerm = "gnome-terminal"

myMod = mod4Mask

myWorkspaces = map show [1..4]

myLayoutHook =
  let nmaster  = 1
      ratio    = 1/2
      delta    = 3/100
      tiled    = Tall nmaster delta ratio
      threeCol = ThreeColMid nmaster delta ratio
      mag      = magnifiercz' 1.3

  in  lessBorders Screen
      $ spacingWithEdge 5
      $ tiled ||| Full ||| (mag $ tiled ||| threeCol)

myManageHook = composeAll
  [ className =? "Element"                  --> doShift "2"
  , className =? "discord"                  --> doShift "2"
  , className =? ".blueman-manager-wrapped" --> doFloat
  ]

-- Only remove mappings that needs pass through.
-- If a new mapping is added, the old one is overridden
myUnmaps =
  [ (myMod, xK_h)
  , (myMod, xK_l)
  ]
  ++ [ ((myMod              , n)) | n <- [xK_1 .. xK_9] ]
  ++ [ ((myMod .|. shiftMask, n)) | n <- [xK_1 .. xK_9] ]

toggleXkbLayout = T.unpack
  [text|
  if setxkbmap -query | grep dvorak-french 2>&1 > /dev/null; then
      setxkbmap dvorak
  else
      setxkbmap dvorak-french
  fi
  |]
externalScreenOnly = T.unpack
  [text|
  if xrandr --output DP-1 --left-of eDP-1 --mode 2560x1440 --rate 59.94; then
      xrandr --output eDP-1 --off
  else
      xrandr --auto
  fi
  |]

myKeymaps =
  let remapWithFallback src dst =
        (src , bindFirst $ dst ++ [ (pure True, uncurry sendKey src) ])
  in  [ -- shortcuts
        ((controlMask .|. mod1Mask, xK_f), spawn "firefox")
      , ((controlMask .|. mod1Mask, xK_z), spawn "xscreensaver-command -lock")
      , ((controlMask .|. mod1Mask, xK_c), spawn $ unwords [ myTerm, "--", "fish -c tmux_cmus" ])

      -- screenshot
      , ((mod4Mask .|. shiftMask, xK_3), spawn "scrot -F - | xclip -in -selection clipboard -t image/png")
      , ((mod4Mask .|. shiftMask, xK_4), spawn "scrot -s -F - | xclip -in -selection clipboard -t image/png")
      , ((controlMask .|. mod4Mask .|. shiftMask, xK_4), spawn "scrot -s")

      -- toggle external display
      , ((controlMask, xK_F7), spawn externalScreenOnly)

      -- FIXME: brightness adjustments
      , ((controlMask, xK_F5), spawn "light -S 10")
      , ((controlMask, xK_F6), spawn "light -A 10")

      -- volume adjustments
      , ((controlMask, xK_F1), spawn "amixer set Master toggle")
      , ((controlMask, xK_F2), spawn "amixer set Master 5%-")
      , ((controlMask, xK_F3), spawn "amixer set Master 5%+")
      , ((0, xF86XK_AudioMute), spawn "amixer set Master toggle")
      , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 5%-")
      , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+")

      -- tab navigation in firefox
      , remapWithFallback
        (controlMask .|. shiftMask, xK_bracketright)
        [ (className =? "firefox", sendKey controlMask xK_Tab) ]
      , remapWithFallback
        (controlMask .|. shiftMask, xK_bracketleft)
        [ (className =? "firefox", sendKey (controlMask .|. shiftMask) xK_Tab) ]

      -- keyboard layout switch
      -- TODO: add direct toggles
      , ((controlMask, xK_space), spawn toggleXkbLayout)

      -- TODO: add media keys configurations

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

-- Xmobar's [p]retty [p]rinter
myXmobarPP = def

myStartupHook = do
  -- system tray
  spawnOnce $ T.unpack
    [text|
    trayer                                              \
        --edge top --align right --SetDockType true     \
        --SetPartialStrut true --expand true --width 10 \
        --transparent false --tint 0xFFFFFF --height 18
    |]
  -- notification daemon
  spawnOnce "/usr/bin/env wired &"
  -- screensaver
  spawnOnce "/usr/bin/env xscreensaver --no-splash &"
  -- bluetooth applet
  spawnOnce "/usr/bin/env blueman-applet &"
  -- external display hack
  spawnOnce externalScreenOnly

  -- launch some useful softwares
  spawnOnce "/usr/bin/env element-desktop &"
  spawnOnce "/usr/bin/env discord &"

  windows $ W.greedyView (myWorkspaces !! 0)

main = xmonad
      . ewmhFullscreen . ewmh
      . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
      $ xmonadConfig

-- vim:et:sw=2:ts=2

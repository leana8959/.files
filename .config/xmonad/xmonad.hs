-- vim:et:sw=2:ts=2

import XMonad
import XMonad.Core

import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce

import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier

import XMonad.Hooks.EwmhDesktops

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import qualified XMonad.Util.Run as Run

myTerm = "gnome-terminal"
runInTerm = Run.runInTerm myTerm

xmonadConfig = def
  { modMask           = mod1Mask
  , terminal          = myTerm
  , focusFollowsMouse = True
  , borderWidth       = 2
  , workspaces        = show <$> [1..4]
  , layoutHook        = myLayout
  , startupHook       = myStartupHook
  } `additionalKeysP` myKeymaps

myLayout =
  let nmaster  = 1
      ratio    = 3/5
      delta    = 3/100
      tiled    = Tall nmaster delta ratio
      threeCol = ThreeColMid nmaster delta ratio
      mag      = magnifiercz' 1.3
  in  mag tiled ||| Mirror tiled ||| Full ||| mag threeCol

myKeymaps =
  [ (("M-C-f"), spawn "firefox")
  , (("M-C-s"), unGrab *> spawn "scrot -s")
  , (("M-C-z"), spawn "xscreensaver-command -lock")
  , (("M-C-c"), runInTerm "fish -c tmux_cmus") -- FIXME:
  ]

-- Xmobar's [p]retty [p]rinter
myXmobarPP = def

myStartupHook = do
  spawnOnce "trayer --edge top --align right --SetDockType true \
            \--SetPartialStrut true --expand true --width 10 \
            \--transparent true --tint 0x5f5f5f --height 18"

main = xmonad
      . ewmhFullscreen . ewmh
      . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
      $ xmonadConfig

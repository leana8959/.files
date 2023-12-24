-- vim:et:sw=2:ts=2

import XMonad
import XMonad.Core

import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab

import XMonad.Layout.Magnifier
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

xmonadConfig = def
  { modMask           = mod4Mask
  , terminal          = myTerm
  , focusFollowsMouse = True
  , borderWidth       = 2
  , workspaces        = show <$> [1..4]
  , layoutHook        = myLayoutHook
  , startupHook       = myStartupHook
  }
  `additionalKeys` myKeymaps

myTerm = "gnome-terminal"

myLayoutHook =
  let nmaster  = 1
      ratio    = 3/5
      delta    = 3/100
      tiled    = Tall nmaster delta ratio
      threeCol = ThreeColMid nmaster delta ratio
      mag      = magnifiercz' 1.3

  in  spacingWithEdge 7
      $ mag tiled ||| Mirror tiled ||| Full ||| mag threeCol

myKeymaps =
  [ ((controlMask .|. mod1Mask, xK_f), spawn "firefox")
  , ((controlMask .|. mod1Mask, xK_s), spawn "scrot -s")
  , ((controlMask .|. mod1Mask, xK_z), spawn "xsreensaver-command -lock")
  , ((controlMask .|. mod1Mask, xK_c), spawn $ unwords [ myTerm, "--", "fish -c tmux_cmus" ])

  -- TODO: https://libreddit.earth2077.fr/r/xmonad/comments/i1s9do/keybinding_send_key_to_application/
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

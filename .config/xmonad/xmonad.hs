{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}

import XMonad
import XMonad.Core

import XMonad.Actions.PerWindowKeys

import XMonad.Util.EZConfig (additionalKeys, removeKeys)
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab
import XMonad.Util.Paste

import XMonad.Layout.Magnifier
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import qualified XMonad.StackSet as W

import NeatInterpolation
import qualified Data.Text as T

xmonadConfig = def
  { modMask            = myMod
  , terminal           = myTerm
  , focusFollowsMouse  = False
  , borderWidth        = 2
  , workspaces         = myWorkspaces
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
      ratio    = 3/5
      delta    = 3/100
      tiled    = Tall nmaster delta ratio
      threeCol = ThreeColMid nmaster delta ratio
      mag      = magnifiercz' 1.3

  in  spacingWithEdge 5
      $ mag tiled ||| Mirror tiled ||| Full ||| mag threeCol


-- Only remove mappings that needs pass through.
-- If a new mapping is added, the old one is overridden
myUnmaps =
  []

myKeymaps =
  let remap src dst =
        ( src
        , bindFirst $ dst ++ [ (pure True, uncurry sendKey src) ]
        )
      toggleXkbLayout = T.unpack
        [text|
        if setxkbmap -query | grep dvorak-french 2>&1 > /dev/null; then
            setxkbmap dvorak
        else
            setxkbmap dvorak-french
        fi
        |]
  in  [ -- shortcuts
        ((controlMask .|. mod1Mask, xK_f), spawn "firefox")
      , ((controlMask .|. mod1Mask, xK_s), spawn "scrot -s")
      , ((controlMask .|. mod1Mask, xK_z), spawn "xsreensaver-command -lock")
      , ((controlMask .|. mod1Mask, xK_c), spawn $ unwords [ myTerm, "--", "fish -c tmux_cmus" ])

      -- tab navigation in firefox
      , remap
        (controlMask .|. shiftMask, xK_bracketright)
        [ (className =? "firefox", sendKey controlMask xK_Tab) ]
      , remap
        (controlMask .|. shiftMask, xK_bracketleft)
        [ (className =? "firefox", sendKey (controlMask .|. shiftMask) xK_Tab) ]

      -- keyboard layout switch
      -- TODO: add direct toggles
      , ((controlMask, xK_space), spawn toggleXkbLayout)

      -- TODO: add media keys configurations
     ]

     -- organic window jumping
     ++ [ ((myMod, n), windows $ W.greedyView space )
          | (n, space) <- zip [xK_h, xK_t, xK_n, xK_s] myWorkspaces
     ]

     -- organic window yeeting
     ++ [ ((myMod .|. shiftMask, n), windows $ W.shift space )
          | (n, space) <- zip [xK_h, xK_t, xK_n, xK_s] myWorkspaces
     ]

-- Xmobar's [p]retty [p]rinter
myXmobarPP = def

myStartupHook = do
  spawnOnce $ T.unpack
    [text|
    trayer --edge top --align right --SetDockType true  \
        --SetPartialStrut true --expand true --width 10 \
        --transparent true --tint 0x5f5f5f --height 18
    |]

main = xmonad
      . ewmhFullscreen . ewmh
      . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
      $ xmonadConfig

-- vim:et:sw=2:ts=2

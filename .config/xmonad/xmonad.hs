{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

import           XMonad

import           XMonad.Actions.PerWindowKeys (bindFirst)

import           XMonad.Util.EZConfig         (additionalKeys, removeKeys)
import           XMonad.Util.NamedScratchpad  (NamedScratchpad (NS),
                                               customFloating,
                                               namedScratchpadAction,
                                               namedScratchpadManageHook,
                                               scratchpadWorkspaceTag)
import           XMonad.Util.Paste            (sendKey)
import           XMonad.Util.SpawnOnce        (spawnOnce)

import           XMonad.Layout.NoBorders      (Ambiguity (OnlyScreenFloat),
                                               lessBorders)
import           XMonad.Layout.Reflect        (reflectHoriz, reflectVert)
import           XMonad.Layout.Renamed        (Rename (Replace), renamed)
import           XMonad.Layout.Spacing        (spacingWithEdge)

import           XMonad.Hooks.DynamicLog      (PP (ppCurrent, ppHiddenNoWindows, ppSep),
                                               filterOutWsPP, wrap, xmobarColor)
import           XMonad.Hooks.EwmhDesktops    (ewmh, ewmhFullscreen)
import           XMonad.Hooks.StatusBar       (defToggleStrutsKey,
                                               statusBarProp, withEasySB)
import           XMonad.Hooks.StatusBar.PP    (PP (ppCurrent, ppHiddenNoWindows, ppSep),
                                               filterOutWsPP, wrap, xmobarColor)

import           Graphics.X11.ExtraTypes.XF86 (xF86XK_AudioLowerVolume,
                                               xF86XK_AudioMute,
                                               xF86XK_AudioNext,
                                               xF86XK_AudioPlay,
                                               xF86XK_AudioPrev,
                                               xF86XK_AudioRaiseVolume,
                                               xF86XK_Display,
                                               xF86XK_MonBrightnessDown,
                                               xF86XK_MonBrightnessUp)

import qualified XMonad.StackSet              as W

import qualified Data.Text                    as T
import           NeatInterpolation            (text)

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

myWorkspaces =
  [ "CODE", "CHAT", "REC", "UNIV"
  , "PERS", "WEB" , "YT", "ADM"
  ]

myLayoutHook =
  let tall = renamed [Replace "virt"]
             . lessBorders OnlyScreenFloat
             . spacingWithEdge 5
             . reflectHoriz
             . reflectVert
             $ Tall 1 (3/100) (1/2)
      full = renamed [Replace "full"]
             . lessBorders OnlyScreenFloat
             . spacingWithEdge 5
             $ Full
  in  tall ||| full

myManageHook =
  let
    centeredFloat = customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)
  in
  composeAll
  [ className =? ".blueman-manager-wrapped"    --> centeredFloat
  , className =? "Eog"                         --> centeredFloat
  , className =? "Org.gnome.NautilusPreviewer" --> centeredFloat
  , className =? "Evince"                      --> centeredFloat
  , title     =? "easyeffects"                 --> centeredFloat
  , title     =? "Picture-in-Picture"          --> doFloat
  , className =? "Element"                     --> doShift "CHAT"
  , className =? "discord"                     --> doShift "CHAT"
  , className =? "thunderbird"                 --> doShift "CHAT"
  , className =? "Mattermost"                  --> doShift "CHAT"
  ]

scratchpads =
  let
    centeredFloat = customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)
  in
  [ NS "cmus"
      (myTerm ++ " -T 'cmus' cmus")
      (title =? "cmus")
      centeredFloat
  , NS "btop"
      (myTerm ++ " -T 'btop' btop")
      (title =? "btop")
      centeredFloat
  , NS "bitwarden"
      "bitwarden"
      (className =? "Bitwarden")
      (customFloating $ W.RationalRect (1/2) (1/6) (2/5) (2/3))
  ]

-- Only remove mappings that needs pass through.
-- If a new mapping is added, the old one is overridden
myUnmaps =
  [ (myMod, xK_h)
  , (myMod, xK_l)
  ]
  ++ [ (myMod              , n) | n <- [xK_1 .. xK_9] ]
  ++ [ (myMod .|. shiftMask, n) | n <- [xK_1 .. xK_9] ]

myKeymaps =
  let remapWithFallback src dst =
        let fallback = [ (pure True, uncurry sendKey src) ]
        in  (src, bindFirst . (++fallback) $ dst)
      workspaceKeys =
        [ xK_h, xK_t, xK_n, xK_s
        , xK_m, xK_w, xK_v, xK_z
        ]
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
      , ( (controlMask .|. mod4Mask, xK_l)
        , spawn "xscreensaver-command -lock"
        )
      , ( (controlMask .|. mod4Mask, xK_z)
        , spawn "xscreensaver-command -lock ; systemctl suspend"
        )
      , ( (shiftMask .|. controlMask .|. mod4Mask, xK_z)
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
      , ((myMod .|. shiftMask, xK_comma) , sendMessage Expand)
      , ((myMod .|. shiftMask, xK_period), sendMessage Shrink)

      -- Increment / decrement the number of windows in the master area
      , ((myMod ,xK_comma ), sendMessage (IncMasterN (-1)))
      , ((myMod ,xK_period), sendMessage (IncMasterN 1))

      -- force back to tiling
      , ((myMod .|. shiftMask, xK_t), withFocused $ windows . W.sink)
     ]

     -- organic window jumping
     ++ [ ((myMod, n), windows $ W.greedyView space)
        | (n, space) <- zip workspaceKeys myWorkspaces]

     -- organic window yeeting
     ++ [ ((myMod .|. mod1Mask, n), windows $ W.shift space)
        | (n, space) <- zip workspaceKeys myWorkspaces]

myPrettyPrinter =
  filterOutWsPP [scratchpadWorkspaceTag]
  $ def
  { ppCurrent         = xmobarColor "#FFFFFF" "" . wrap "[" "]"
  , ppHiddenNoWindows = xmobarColor "#9c9c9c" ""
  , ppSep             = " | "
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

main = xmonad
      . ewmhFullscreen . ewmh
      . withEasySB
        (statusBarProp setupXmobar (pure myPrettyPrinter))
        defToggleStrutsKey
      $ xmonadConfig

-- vim:et:sw=2:ts=2

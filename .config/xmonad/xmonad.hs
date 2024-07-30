{-# LANGUAGE OverloadedStrings #-}

import           XMonad                       hiding (tile)

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
                                               statusBarProp, withEasySB, dynamicSBs,
                                               StatusBarConfig, statusBarPropTo,
                                               dynamicEasySBs)
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

import           Control.Monad                (msum)
import           Data.Ratio                   (Ratio, (%))

import qualified Data.Text                    as T

xmonadConfig = def
  { modMask            = myMod
  , terminal           = myTerm
  , focusFollowsMouse  = True
  , borderWidth        = 5
  , workspaces         = myWorkspaces
  , manageHook         = myManageHook
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

data TallR a = TallR { tallNMaster        :: !Int      -- ^ The default number of windows in the master pane (default: 1)
                     , tallRatioIncrement :: !Rational -- ^ Percent of screen to increment by when resizing panes (default: 3/100)
                     , tallRatio          :: !Rational -- ^ Default proportion of screen occupied by master pane (default: 1/2)
                     }
              deriving (Show, Read)

instance LayoutClass TallR a where
    description _ = "Tall"

    pureLayout (TallR nmaster _ frac) r s = zip ws rs
      where ws = W.integrate s
            rs = tile frac r nmaster (length ws)

    pureMessage (TallR nmaster delta frac) m =
            msum [fmap resize     (fromMessage m)
                 ,fmap incmastern (fromMessage m)]

      where resize Shrink             = TallR nmaster delta (max 0 $ frac-delta)
            resize Expand             = TallR nmaster delta (min 1 $ frac+delta)
            incmastern (IncMasterN d) = TallR (max 0 (nmaster+d)) delta frac

-- A modified verison of the built-in `tile` function
-- that puts master on the right
tile
    :: Rational  -- ^ @frac@, what proportion of the screen to devote to the master area
    -> Rectangle -- ^ @r@, the rectangle representing the screen
    -> Int       -- ^ @nmaster@, the number of windows in the master pane
    -> Int       -- ^ @n@, the total number of windows to tile
    -> [Rectangle]
tile f r nmaster n =
  if n <= nmaster || nmaster == 0
    then splitVertically n r
    else
      let (r1, r2) = splitHorizontallyBy f r
      in  splitVertically nmaster r2 ++ splitVertically (n-nmaster) r1

myLayoutHook =
  let tall = renamed [Replace "virt"]
             . lessBorders OnlyScreenFloat
             . spacingWithEdge 5
             $ TallR 1 (3/100) (1/2)
      full = renamed [Replace "full"]
             . lessBorders OnlyScreenFloat
             . spacingWithEdge 5
             $ Full

  in  tall ||| full

centeredFloat = customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)
longFloat     = customFloating $ W.RationalRect (2/7) 0 (3/7) 1

myManageHook =
  composeAll
  [ className =? ".blueman-manager-wrapped"    --> centeredFloat
  , className =? "Eog"                         --> centeredFloat
  , className =? "Org.gnome.NautilusPreviewer" --> centeredFloat
  , className =? "Evince"                      --> longFloat
  , title     =? "easyeffects"                 --> centeredFloat
  , title     =? "Picture-in-Picture"          --> doFloat
  , className =? "Element"                     --> doShift "CHAT"
  , className =? "discord"                     --> doShift "CHAT"
  , className =? "thunderbird"                 --> doShift "CHAT"
  , className =? "Mattermost"                  --> doShift "CHAT"
  ]
  <+> namedScratchpadManageHook myScratchpads

myScratchpads =
  [ NS "cmus"
      (myTerm ++ " -T 'cmus' cmus")
      (title =? "cmus")
      centeredFloat
  , NS "btop"
      (myTerm ++ " -T 'btop' btop")
      (title =? "btop")
      centeredFloat
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
        ((controlMask .|. myMod, xK_f), spawn "firefox-esr")
      , ((controlMask .|. myMod, xK_m), namedScratchpadAction myScratchpads "cmus")
      , ((controlMask .|. myMod, xK_t), namedScratchpadAction myScratchpads "btop")

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

      -- reset builtin display
      , ((0, xF86XK_Display), spawn "xrandr --output eDP-1 --auto")

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
      , ((myMod .|. shiftMask, xK_comma) , sendMessage Shrink)
      , ((myMod .|. shiftMask, xK_period), sendMessage Expand)

      -- Increment / decrement the number of windows in the master area
      , ((myMod ,xK_comma ), sendMessage (IncMasterN (-1)))
      , ((myMod ,xK_period), sendMessage (IncMasterN 1))

      -- sink
      , ((myMod .|. shiftMask, xK_s), withFocused $ windows . W.sink)
     ]

     -- organic window jumping
     ++ [ ((myMod, n), windows $ W.greedyView space)
        | (n, space) <- zip workspaceKeys myWorkspaces ]

     -- organic window yeeting
     ++ [ ((myMod .|. mod1Mask, n), windows $ W.shift space)
        | (n, space) <- zip workspaceKeys myWorkspaces ]

myPrettyPrinter =
  filterOutWsPP [scratchpadWorkspaceTag]
  $ def
  { ppCurrent         = xmobarColor "#FFFFFF" "" . wrap "[" "]"
  , ppHiddenNoWindows = xmobarColor "#9c9c9c" ""
  , ppSep             = " | "
  }

myStartupHook = do
  spawnOnce "fcitx5 &" -- Input method
  spawnOnce "xscreensaver --no-splash &" -- Screensaver
  spawnOnce "playerctld daemon" -- Player controller
  spawnOnce "wired &" -- Notification daemon
  spawn "feh --no-fehbg --bg-fill ~/.wallpaper &" -- wallpaper

xmobarOf :: ScreenId -> IO StatusBarConfig
xmobarOf 0 = pure $ statusBarProp "xmobar -x 0 ~/.config/xmobar/xmobarrc" (pure myPrettyPrinter)
xmobarOf 1 = pure $ statusBarProp "xmobar -x 1 ~/.config/xmobar/xmobarrc" (pure myPrettyPrinter)
xmobarOf _ = mempty

main = xmonad
      . ewmhFullscreen . ewmh
      -- This does the docks and avoidStruts behind the scene
      -- FIXME: is it normal that `xmonad --restart` makes xmobar above a fullscreen window
      . dynamicEasySBs xmobarOf
      $ xmonadConfig

-- vim:et:sw=2:ts=2

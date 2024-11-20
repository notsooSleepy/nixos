_:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      exec-once = swww init
      # exec-once = swww img ~/.config/wallpaper1.png -o DP-1
      # exec-once = swww img ~/.config/wallpaper2.png -o HDMI-A-1
      # exec-once = swww img ~/.config/wallpaper3.png -o DP-3
      # exec-once = swww img ~/.config/wallpaper1.png -o LVDS-1
      exec-once = swww clear 111111

      exec-once = swayidle timeout 600 'hyprctl dispatcher dpms off && swaylock --color 000000'

      exec-once = waybar

      exec-once = nm-applet --indicator
      exec-once = blueman-applet

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = DP-1, 1920x1080, 1920x490, 1
      monitor = HDMI-A-1, 1920x1080, 3840x0, 1, transform, 3
      monitor = DP-3, 1920x1080@50, 0x490, 1,

      workspace = 1, monitor:DP-1, default:true 
      workspace = 2, monitor:DP-1,
      workspace = 3, monitor:DP-1,
      workspace = 4, monitor:DP-1,
      workspace = 5, monitor:DP-1,
      workspace = 6, monitor:HDMI-A-1, default:true 
      workspace = 7, monitor:DP-2, dafault:true 

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = pl
          kb_variant =
          kb_model =
          kb_rules =
          kb_options = ctrl:nocaps
          repeat_delay = 300
          repeat_rate = 50
          follow_mouse = 3
          touchpad {
            natural_scroll = no
            disable_while_typing = true
          }
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
          numlock_by_default = true
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 2
          gaps_out = 5
          border_size = 1
          layout = dwindle
          col.active_border = rgb(cc241d) rgb(d79921) 45deg
          col.inactive_border = rgb(1d2021)
      }

      misc {
          mouse_move_enables_dpms = true
          key_press_enables_dpms = true
          disable_hyprland_logo = true
          disable_splash_rendering = true
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 3
          blur {
            enabled = true
            size = 3
            passes = 1
          }
          active_opacity = 1
          inactive_opacity = 1
      }

      animations {
          enabled = true
          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
          bezier=overshot,0.05,0.9,0.1,1.1
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      }

      cursor {
          hide_on_key_press = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = true
          #workspace_swipe_fingers = 3
          #workspace_swipe_distance = 300
          workspace_swipe_invert = true
          workspace_swipe_min_speed_to_force = 10
          workspace_swipe_cancel_ratio = 0.85
      }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$


      windowrule = opacity 1.0 override 1.0 override,^(kitty)$ # set opacity to 1.0 active and 0.5 inactive for kitty
      # windowrule = float,^(kitty)$ 
      # windowrule = noinitialfocus,^(kitty)$ 


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod , RETURN, exec, kitty
      bind = $mainMod , apostrophe, exec, kitty nvim

      bind = $mainMod, s, exec, rofi -show drun - config ~/.config/rofi/config.rasi

      bind = $mainMod SHIFT, s, exec, grimblast --notify copy area
      bind = $mainMod SHIFT, d, exec, grimblast --notify save area

      bind = $mainMod SHIFT, backslash, exec, swww img ~/.config/wallpaper1.png -o DP-1
      bind = $mainMod SHIFT, backslash, exec, swww img ~/.config/wallpaper2.png -o HDMI-A-1
      bind = $mainMod SHIFT, backslash, exec, swww img ~/.config/wallpaper3.png -o DP-2
      bind = $mainMod SHIFT, backslash, exec, swww img ~/.config/wallpaper1.png -o LVDS-1
      bind = $mainMod, backslash, exec, swww clear 111111

      bind = $mainMod, bracketright, exec, swaylock --color 000000

      bind = $mainMod, W, killactive, 
      bind = $mainMod SHIFT, Q, exit, 
      bind = $mainMod, b, pseudo, # dwindle
      bind = $mainMod, x, togglesplit, # dwindle
      bind = $mainMod, c, togglefloating, 
      bind = $mainMod, v, fullscreen, 0

      # Move focus with mainMod + arrow keys
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d
      bind = $mainMod, T, cyclenext,          # change focus to another window
      bind = $mainMod, T, bringactivetotop,   # bring it to the top 

      bind = $mainMod CTRL, H, movewindow, l
      bind = $mainMod CTRL, L, movewindow, r
      bind = $mainMod CTRL, K, movewindow, u
      bind = $mainMod CTRL, J, movewindow, d

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Monitors
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, SPACE, workspace, m+1
      bind = $mainMod CTRL, SPACE, workspace, r+1
      bind = $mainMod CTRL, INSERT, movetoworkspace, r+1
    '';
  };
}

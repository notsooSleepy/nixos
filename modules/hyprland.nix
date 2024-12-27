_:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      exec-once = sleep 5 && swww-daemon && sleep 5
      exec-once = swww img ~/.config/wallpaper4.png -o DP-1
      # exec-once = swww img ~/.config/wallpaper1.png -o DP-1
      # exec-once = swww img ~/.config/wallpaper2.png -o HDMI-A-1
      # exec-once = swww img ~/.config/wallpaper3.png -o DP-3
      # exec-once = swww img ~/.config/wallpaper1.png -o LVDS-1
      exec-once = swww clear 111111

      exec-once = swayidle timeout 600 'hyprctl dispatcher dpms off && swaylock --color 000000'

      exec-once = waybar

      exec-once = nm-applet --indicator
      exec-once = blueman-applet
      # exec-once = barrier

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = DP-1, 1920x1080, 0x0, 1
      monitor = HDMI-A-1, 1920x1080, 3000x0, 1, transform, 3
      monitor = DP-3, 1920x1080@50, 0x0, 1, transform, 1
      monitor = desc:Samsung Electric Company Odyssey G95C HNTX400441, 5120x1440@239.76, 0x0, 1

      workspace = 1, monitor:desc:Samsung Electric Company Odyssey G95C HNTX400441, default:true, layoutopt:orientation:center
      workspace = 5, monitor:desc:DP-1, default:true, layoutopt:orientation:center
      workspace = 6, monitor:HDMI-A-1, default:true, layoutopt:orientation:bottom
      workspace = 7, monitor:DP-3, dafault:true,layoutopt:orientation:bottom

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = pl
          kb_variant =
          kb_model =
          kb_rules =
          kb_options = ctrl:nocaps
          repeat_delay = 300
          repeat_rate = 50
          follow_mouse = 1
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
          layout = master
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
          pseudotile = false
          preserve_split = true # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          allow_small_split = true
          mfact = 0.5
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

      # Windowrules
      windowrule = opacity 1.0 override 0.8 override,^(kitty)$ # set opacity to 1.0 active and 0.5 inactive for kitty

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      # Layout switcher
      bind = $mainMod, bracketleft, exec, hyprctl keyword general:layout "dwindle"
      bind = $mainMod, bracketleft, exec, notify-send "layout" "dwindle" -t 500
      bind = $mainMod, bracketright, exec, hyprctl keyword general:layout "master"
      bind = $mainMod, bracketright, exec, notify-send "layout" "master" -t 500

      # Kitty
      bind = $mainMod, RETURN, exec, kitty
      bind = $mainMod, apostrophe, exec, kitty nvim
      bind = $mainMod, semicolon, exec, kitty lf

      # Rofi
      bind = $mainMod, s, exec, rofi -show drun - config ~/.config/rofi/config.rasi

      # Grimblast
      bind = $mainMod ALT, s, exec, grimblast --notify copy area
      bind = $mainMod ALT, d, exec, grimblast --notify save area

      # Wallpapers
      bind = $mainMod ALT, backslash, exec, swww img ~/.config/wallpaper1.png -o DP-1
      bind = $mainMod ALT, backslash, exec, swww img ~/.config/wallpaper2.png -o HDMI-A-1
      bind = $mainMod ALT, backslash, exec, swww img ~/.config/wallpaper3.png -o DP-3
      bind = $mainMod ALT, backslash, exec, swww img ~/.config/wallpaper1.png -o LVDS-1
      bind = $mainMod, backslash, exec, swww clear 111111

      bind = $mainMod, minus, exec, swaylock --color 000000

      bind = $mainMod, W, killactive, 
      bind = $mainMod SHIFT, Q, exit, 

      bind = $mainMod, c, togglefloating, 
      bind = $mainMod, v, fullscreen, 0

      # Move focus with mainMod + arrow keys
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d

      # Move window
      bind = $mainMod ALT, H, movewindow, l
      bind = $mainMod ALT, L, movewindow, r
      bind = $mainMod ALT, K, movewindow, u
      bind = $mainMod ALT, J, movewindow, d

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Resize with keyboard
      bind = $mainMod, left, resizeactive, -100 0
      bind = $mainMod, right, resizeactive, 100 0
      bind = $mainMod, up, resizeactive, 0 -100
      bind = $mainMod, down, resizeactive, 0 100

      # Move focus
      bind = $mainMod, z, layoutmsg, swapwithmaster auto
      bind = $mainMod, z, pseudo
      bind = $mainMod, x, layoutmsg, focusmaster master
      bind = $mainMod, x, togglesplit
      bind = $mainMod, q, layoutmsg, addmaster
      bind = $mainMod, a, focusurgentorlast
      bind = $mainMod, t, cyclenext,          # change focus to another window
      bind = $mainMod, t, bringactivetotop,   # bring it to the top 
      bind = $mainMod, TAB, workspace, m+1
      bind = $mainMod, GRAVE, movetoworkspace, r+1
      bind = $mainMod ALT, TAB, movetoworkspacesilent, r+1

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

      # Move to monitor
      bind = $mainMod ALT, 1, movetoworkspace, 1
      bind = $mainMod ALT, 2, movetoworkspace, 2
      bind = $mainMod ALT, 3, movetoworkspace, 3
      bind = $mainMod ALT, 4, movetoworkspace, 4
      bind = $mainMod ALT, 5, movetoworkspace, 5
      bind = $mainMod ALT, 6, movetoworkspace, 6
      bind = $mainMod ALT, 7, movetoworkspace, 7
      bind = $mainMod ALT, 8, movetoworkspace, 8
      bind = $mainMod ALT, 9, movetoworkspace, 9
    '';
  };
}

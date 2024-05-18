_:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" "custom/thunar"];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "custom/power"
          "mpd"
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "power-profiles-daemon"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "keyboard-state"
          "sway/language"
          "battery"
          "battery_bat2"
          "clock"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };

        "hyprland/window" = {
            max-length = 200;
            separate-outputs = true;
        };

        mpd = {
          format= "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
          format-disconnected = "Disconnected ";
          format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
          unknown-tag = "N/A";
          interval = 5;
          consume-icons = {
              on = " ";
          };
          random-icons = {
              off = ''<span color=\"#f53c3c\"></span>'';
              on = " ";
          };
          repeat-icons = {
              on = " ";
          };
          single-icons = {
              on = "1 ";
          };
          state-icons = {
              paused = "";
              playing = "";
          };
          tooltip-format = "MPD (connected)";
          tooltip-format-disconnected = "MPD (disconnected)";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          # icon-size = 21;
          spacing = 10;
        };
        clock = {
          # timezone = "America/New_York";
          tooltip-format = ''<big>{:%Y %B}</big>\n<tt><small>{calendar}</small>w/ttw'';
          format-alt = ''{:%Y-%m-%d}'';
        };
        cpu = {
          format = ''{usage}% '';
          tooltip = true;
        };
        memory = {
          format = "{}% ";
          tooltip = true;
        };
        temperature = {
          # thermal-zone = 2;
          # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          # format-critical = "{temperatureC}°C {icon}";
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
        };
        backlight = {
          #  device = "acpi_video1";
          format = "{percent}% {icon}";
          format-icons = ["" "" "" "" "" "" "" "" ""];
        };
        battery = {
          states = {
            # good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          # format-good = ""; # An empty format will hide the module
          # format-full = "";
          format-icons = ["" "" "" "" ""];
        };
        battery_bat2 = {
            bat = "BAT2";
        };
        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = ''Power profile: {profile}\nDriver: {driver}'';
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };
        network = {
            # interface = "wlp2*"; # (Optional) To force the use of this interface
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} 󰈁";
            tooltip-format = "{ifname} via {gwaddr}";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        pulseaudio = {
            # scroll-step = 1; # %; can be a float;
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = ["" "" ""];
            };
            on-click = "pavucontrol";
        };
        "custom/thunar" = {
            format = "󱇙";
            on-click = "thunar";
            };
        "custom/power" = {
          format = "󰐥";
          on-click = "wlogout";
          };

      };
    };
      style =  ''
* {
	border: none;
	border-radius: 10;
  font-family: "JetbrainsMono Nerd Font" ;
	font-size: 15px;
	min-height: 10px;
}

window#waybar {
	background: transparent;
}

window#waybar.hidden {
	opacity: 0.2;
}

#window {
	margin-top: 6px;
	padding-left: 10px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
        color: #1f2335;
	background: #bb9af7;
}
#tags {
	margin-top: 6px;
	margin-left: 12px;
	font-size: 4px;
	margin-bottom: 0px;
	border-radius: 10px;
	background: #1f2335;
	transition: none;
}

#tags {
	margin-top: 6px;
	margin-left: 12px;
	font-size: 4px;
	margin-bottom: 0px;
	border-radius: 10px;
	background: #1f2335;
	transition: none;
}

#tags button {
	transition: none;
	color: #1f2335;
	background: transparent;
	font-size: 16px;
	border-radius: 2px;
}

#tags button.occupied {
	transition: none;
	color: #F28FAD;
	background: transparent;
	font-size: 4px;
}

#tags button.focused {
	color: #ABE9B3;
    border-top: 2px solid #ABE9B3;
    border-bottom: 2px solid #ABE9B3;
}

#tags button:hover {
	transition: none;
	box-shadow: inherit;
	text-shadow: inherit;
	color: #FAE3B0;
    border-color: #E8A2AF;
    color: #E8A2AF;
}

#tags button.focused:hover {
  color: #E8A2AF;
}

#workspaces button {
  padding: 0 5px;
  background: transparent;
  color: #c0caf5;
}


#temperature {
  margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #1f2335;
	background: #9d7cd8;
}

#temperature.critical {
    background: #ff757f;
    color: transparent;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#battery {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #1f2335;
	background: #9d7cd8;
}

#battery.charging, #battery.plugged {
	color: transparent;
    background: #4fd6be;
}

#battery.critical:not(.charging) {
    background: #ff757f;
    color: transparent;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#power-profiles-daemon {
          padding-right: 15px;
      }

#power-profiles-daemon.performance {
          background: #ff757f;
          color: #9d7cd8;
      }

#power-profiles-daemon.balanced {
          background: #9d7cd8;
          color: #1f2335;
      }

#power-profiles-daemon.power-saver {
          background: #9d7cd8;
          color: #1f2335;
      }

      label:focus {
          background: #9d7cd8;
      }

#disk {
          background: #9d7cd8;
      }
#network {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #1f2335;
	background: #9d7cd8;
}

#pulseaudio {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #1f2335;
	background: #9d7cd8;
}

@keyframes blink {
    to {
        background: #9d7cd8;
        color: #1f2335;
    }
}

#backlight {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #1f2335;
	background: #9d7cd8;
}

#clock {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #1f2335;
	background: #9d7cd8;
}

#memory {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	margin-bottom: 0px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #1f2335;
	background: #9d7cd8;
}

#cpu {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	margin-bottom: 0px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #1f2335;
	background: #9d7cd8;
}

#tray {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	margin-bottom: 0px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #1f2335;
	background: #9d7cd8;
}

#custom-power {
	font-size: 20px;
	margin-top: 6px;
	margin-left: 8px;
	margin-right: 8px;
	padding-left: 10px;
	padding-right: 12px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #1f2335;
	background: #9d7cd8;
}

#custom-thunar {
        font-size: 20px;
	margin-top: 6px;
	margin-left: 8px;
        margin-right: 8px;
	padding-left: 10px;
	padding-right: 14px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #1f2335;
	background: #9d7cd8;
}

#idle_inhibitor {
	margin-top: 6px;
	margin-left: 4px;
	padding-left: 10px;
	padding-right: 15px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #1f2335;
	background: #9d7cd8;
}

#idle_inhibitor.activated {
        margin-top: 6px;
	margin-left: 4px;
	padding-left: 10px;
	padding-right: 15px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
        color: #1f2335;
	background: #9d7cd8;
}

#mpd {
  background: #9d7cd8;
  color: #1f2335;
}

#mpd.disconnected {
          background: #9d7cd8;
      }

#mpd.stopped {
          background: #9d7cd8;
      }

#mpd.paused {
          background: #9d7cd8;
      }

#language {
          background: #9d7cd8;
          color: #1f2335;
          padding: 0 5px;
          margin: 0 5px;
          min-width: 16px;
      }

#keyboard-state {
          background: #9d7cd8;
          color: #1f2335;
          padding: 0 0px;
          margin: 0 5px;
          min-width: 16px;
      }

#keyboard-state > label {
          padding: 0 5px;
      }

#keyboard-state > label.locked {
          background: rgba(0, 0, 0, 0.2);
      }

#scratchpad {
          background: rgba(0, 0, 0, 0.2);
      }

#scratchpad.empty {
        background-color: transparent;
      }

#privacy {
          padding: 0;
      }

#privacy-item {
          padding: 0 5px;
          color: white;
      }

#privacy-item.screenshare {
          background: #9d7cd8;
      }

#privacy-item.audio-in {
          background: #9d7cd8;
      }

#privacy-item.audio-out {
          background: #9d7cd8;
      }
      '';
    };
}

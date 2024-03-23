{ pkgs, ... }:
let
    pkgs = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz";
        sha256 = "1l2hq1n1jl2l64fdcpq3jrfphaz10sd1cpsax3xdya0xgsncgcsi";
    }) {};

    myPkg = pkgs.wireplumber;
in
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" "custom/media"];
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
        "custom/media" = {
            format = "{icon} {}";
            return-type = "json";
            max-length = 40;
            format-icons = {
                spotify = "";
                default = "";
            };
        };
        "custom/power" = {
          format = "󰐥 ";
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
  color: #282828;
	background: #98971a;
}
#tags {
	margin-top: 6px;
	margin-left: 12px;
	font-size: 4px;
	margin-bottom: 0px;
	border-radius: 10px;
	background: #282828;
	transition: none;
}

#tags {
	margin-top: 6px;
	margin-left: 12px;
	font-size: 4px;
	margin-bottom: 0px;
	border-radius: 10px;
	background: #282828;
	transition: none;
}

#tags button {
	transition: none;
	color: #282828;
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
  color: #ebdbb2;
}


#temperature {
  margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #282828;
	background: #458588;
}

#temperature.critical {
    background: #cc241d;
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
	color: #282828;
	background: #b16286;
}

#battery.charging, #battery.plugged {
	color: transparent;
    background: #689d6a;
}

#battery.critical:not(.charging) {
    background: #cc241d;
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
          background: #f53c3c;
          color: #ffffff;
      }

#power-profiles-daemon.balanced {
          background: #2980b9;
          color: #ffffff;
      }

#power-profiles-daemon.power-saver {
          background: #2ecc71;
          color: #000000;
      }

      label:focus {
          background: #000000;
      }

#disk {
          background: #964B00;
      }
#network {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #282828;
	background: #928374;
}

#pulseaudio {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #282828;
	background: #98971a;
}

@keyframes blink {
    to {
        background: #BF616A;
        color: #B5E8E0;
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
	color: #282828;
	background: #F8BD96;
}

#clock {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #282828;
	background: #d79921;
}

#memory {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	margin-bottom: 0px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #282828;
	background: #ebdbb2;
}

#cpu {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	margin-bottom: 0px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #282828;
	background: #fe8019;
}

#tray {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	margin-bottom: 0px;
	padding-right: 10px;
	border-radius: 10px;
	transition: none;
	color: #282828;
	background: #a89984;
}

#custom-power {
	font-size: 20px;
	margin-top: 6px;
	margin-left: 8px;
	margin-right: 8px;
	padding-left: 10px;
	padding-right: 5px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #282828;
	background: #83a598;
}

#custom-media {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #282828;
	background: #fabd2f;
}

#idle_inhibitor {
	margin-top: 6px;
	margin-left: 4px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
	color: #282828;
	background: #458588;
}

#idle_inhibitor.activated {
  margin-top: 6px;
	margin-left: 4px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
  color: #282828;
	background: #F2CDCD;
}

#mpd {
  background: #66cc99;
  color: #2a5c45;
}

#mpd.disconnected {
          background: #f53c3c;
      }

#mpd.stopped {
          background: #90b1b1;
      }

#mpd.paused {
          background: #51a37a;
      }

#language {
          background: #00b093;
          color: #740864;
          padding: 0 5px;
          margin: 0 5px;
          min-width: 16px;
      }

#keyboard-state {
          background: #97e1ad;
          color: #000000;
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
          background: #cf5700;
      }

#privacy-item.audio-in {
          background: #1ca000;
      }

#privacy-item.audio-out {
          background: #0069d4;
      }
      '';
    };
}

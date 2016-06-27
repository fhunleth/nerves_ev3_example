# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :nerves, :firmware,
  fwup_conf: "config/fwup.conf",
  rootfs_additions: "config/rootfs-additions"

# if unset, the default regulatory domain is the world domain, "00"
config :nerves_interim_wifi,
  regulatory_domain: "US"

# Change these options to your
config :nerves_ev3_example, :wlan0,
  ssid: "hunleth",
  key_mgmt: :"WPA-PSK",
  psk: "ahqwlhvjgxsltfmy"

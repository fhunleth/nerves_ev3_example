# Nerves Lego EV3 Example

To try this out, you'll need an EV3 and a WiFi adapter. See
https://github.com/nerves-project/nerves_system_ev3 for supported WiFi
adapters. Also, keep in mind that support for the EV3 is in progress.
Having a console adapter will come in handy.

Here are the steps:

  1. Edit `config/config.exs` and add your access point
  2. `mix deps.get`
  3. `mix firmware`
  4. Connect a MicroSD card to your computer.
  5. `mix firmware.burn`
  6. Put the MicroSD card in the EV3 and power off the EV3
  7. Watch the display. It should eventually show an IP address.
  8. On your computer, run `iex --cookie democookie --sname me --remsh
     ev3@nerves-129d` to connect. If your router doesn't supply local DNS,
     you'll need to add `nerves-129d` to your `/etc/hosts`.


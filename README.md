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

Once you connect, you'll want to do stuff with Lego sensors and motors that you
may have attached to your EV3. The docs for doing this can be found on the
[ev3dev](http://www.ev3dev.org) website and pretty much just need to be
translated from shell commands (you could use `:os.cmd` if you want) to Elixir
[File](https://hexdocs.pm/elixir/File.html) calls. For example, if you have a
motor, see the [tacho-motor](http://www.ev3dev.org/docs/tutorials/tacho-motors/)
instructions.

If you have a console adapter and want to do some debugging with this project,
you'll need to do two things. The first is to switch the TTY to `ttyS1` in
`config/rootfs-additions/etc/erlinit.config`. The second is to comment out the
`NervesEv3Example.Display` worker so that it doesn't start in
`lib/nerves_ev3_example.ex`.

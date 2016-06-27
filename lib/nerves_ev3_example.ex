defmodule NervesEv3Example do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Initialize
    load_ev3_modules()
    start_writable_fs()
    start_wifi()

    # Define workers and child supervisors to be supervised
    children = [
      worker(NervesEv3Example.Display, []),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NervesEv3Example.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp load_ev3_modules() do
    System.cmd("modprobe", ["suart_emu"])
    System.cmd("modprobe", ["legoev3_ports"])
    System.cmd("modprobe", ["snd_legoev3"])
    System.cmd("modprobe", ["legoev3_battery"])

    # I'm currently using a Ralink RT53xx WiFi dongle
    System.cmd("modprobe", ["rt2800usb"])
  end

  defp start_wifi() do
    opts = Application.get_env(:nerves_ev3_example, :wlan0)
    Nerves.InterimWiFi.setup "wlan0", opts
  end

  defp redirect_logging() do
    Logger.add_backend {LoggerFileBackend, :error}
    Logger.configure_backend {LoggerFileBackend, :error},
      path: "/root/system.log",
      level: :info
  end

  defp format_appdata() do
    case System.cmd("mke2fs", ["-t", "ext4", "-L", "APPDATA", "/dev/mmcblk0p3"]) do
      {_, 0} -> :ok
      _ -> :error
    end
  end

  defp maybe_mount_appdata() do
    if !File.exists?("/root/.initialized") do
      mount_appdata()
    else
      :ok
    end
  end

  defp mount_appdata() do
    case System.cmd("mount", ["-t", "ext4", "/dev/mmcblk0p3", "/root"]) do
      {_, 0} -> :ok
      _ -> :error
    end
  end

  defp start_writable_fs() do
    case maybe_mount_appdata() do
      :ok ->
        redirect_logging()
      :error ->
        case format_appdata() do
          :ok ->
            mount_appdata()
            redirect_logging()
          error -> error
        end
    end
  end

end

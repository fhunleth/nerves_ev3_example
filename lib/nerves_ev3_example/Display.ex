defmodule NervesEv3Example.Display do
  use GenServer

  def start_link(args, options \\ []) do
    GenServer.start_link(__MODULE__, args, options)
  end

  def init(_) do
    ExNcurses.initscr()
    :timer.send_interval(1000, :refresh)
    {:ok, 0}
  end

  def handle_info(:refresh, state) do
    ExNcurses.mvprintw(3, 1, "Hello #{state}")
    {:noreply@n, state}
  end
end

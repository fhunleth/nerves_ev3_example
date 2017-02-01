defmodule NervesEv3Example.Mixfile do
  use Mix.Project

@system "nerves_system_ev3"

  def project do
    [app: :nerves_ev3_example,
     version: "0.2.0",
     elixir: "~> 1.3",
     archives: [nerves_bootstrap: "~> 0.2"],
     deps_path: "deps/#{@system}",
     build_path: "_build/#{@system}",
     system: @system,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps() ++ system()]
  end

  def application do
    [mod: {NervesEv3Example, []},
     applications: [:logger, :logger_file_backend, :nerves_interim_wifi, :ex_ncurses, :runtime_tools]]
  end

  defp deps do
    [{:nerves, "~> 0.4", runtime: false},
     {:logger_file_backend, "~> 0.0.8"},
     {:nerves_interim_wifi, "~> 0.0.1"},
     {:ex_ncurses, github: "jfreeze/ex_ncurses", ref: "2fd3ecb1c8a1c5e04ddb496bb8d57f30b619f59e"},
    ]
  end

  def system do
    [{:nerves_system_ev3, "~> 0.9.0", runtime: false}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end

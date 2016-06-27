defmodule NervesEv3Example.Mixfile do
  use Mix.Project

  def project do
    [app: :nerves_ev3_example,
     version: "0.0.1",
     archives: [nerves_bootstrap: "0.1.3"],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {NervesEv3Example, []},
     applications: [:nerves, :logger]]
  end

  def deps do
    [{:nerves, "~> 0.3.0"},
     {:nerves_system_ev3, github: "nerves-project/nerves_system_ev3", branch: "pre"},
     {:nerves_system, github: "nerves-project/nerves_system", branch: "master", override: true},
     {:nerves_toolchain, github: "nerves-project/nerves_toolchain", branch: "master", override: true}
    ]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end

defmodule NervesSystemRpi3.Mixfile do
  use Mix.Project

  @app :rosetta_rpi3
  @version Path.join(__DIR__, "VERSION")
           |> File.read!()
           |> String.trim()

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.4",
      compilers: Mix.compilers() ++ [:nerves_package],
      nerves_package: nerves_package(),
      description: description(),
      package: package(),
      deps: deps(),
      aliases: [
        "deps.precompile": ["nerves.env", "deps.precompile"],
        "deps.get": ["deps.get", "nerves.deps.get"]]
    ]
  end

  def application do
    []
  end

  def nerves_package do
    [
      type: :system,
      artifact_sites: [
        {:github_releases, "rosetta-home/#{@app}"}
      ],
      platform: Nerves.System.BR,
      platform_config: [
        defconfig: "nerves_defconfig"
      ],
      checksum: package_files()
    ]
  end

  defp deps do
    [
      {:nerves, "~> 0.10.1", runtime: false},
      {:nerves_system_br, "0.17.0", runtime: false},
      {:nerves_toolchain_arm_unknown_linux_gnueabihf, "~> 0.13.0", runtime: false},
      {:nerves_system_linter, "~> 0.2.2", runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
    """
    Nerves System - Raspberry Pi 3 B
    """
  end

  defp package do
    [
      maintainers: ["Christopher Coté"],
      files: package_files(),
      licenses: ["Apache 2.0"],
      links: %{"Github" => "https://github.com/rosetta-home/#{@app}"}
    ]
  end

  defp package_files do
    [
      "LICENSE",
      "mix.exs",
      "nerves_defconfig",
      "README.md",
      "VERSION",
      "rootfs_overlay",
      "fwup.conf",
      "fwup-revert.conf",
      "post-createfs.sh",
      "post-build.sh",
      "cmdline.txt",
      "linux-4.4.defconfig",
      "config.txt"
    ]
  end
end

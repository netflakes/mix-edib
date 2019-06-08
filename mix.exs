Code.eval_file "tasks/readme.exs"

defmodule EDIB.Mixfile do
  use Mix.Project

  @version "0.11.1"

  def project do
    [
      app:           :edib,
      name:          "edib",
      version:       @version,
      elixir:        "~> 1.6",
      deps:          deps(),
      description:   description(),
      package:       package(),
      source_url:    "https://github.com/edib-tool/mix-edib",
      homepage_url:  "http://hexdocs.pm/mix-edib",
      docs:          &docs/0,
      test_coverage: [tool: ExCoveralls, test_task: "espec"],
      preferred_cli_env: [espec: :test],
      aliases: aliases(),
    ]
  end

  def application, do: [applications: [:logger]]

  defp description do
    """
    Mix task to create a docker image of your application release.

    Installation: `mix archive.install hex edib`

    More detailed information about release image building at:

    https://github.com/edib-tool/elixir-docker-image-builder
    """
  end

  defp docs do
    [
      extras:     ["README.md"],
      main:       "readme",
      source_ref: "v#{@version}",
      source_url: "https://github.com/edib-tool/mix-edib"
    ]
  end

  defp package do
    [
      files:        ["lib", "tasks", "mix.exs", "README.md", "LICENSE"],
      maintainers:  ["Christoph Grabo"],
      licenses:     ["MIT"],
      links: %{
        "GitHub" => "https://github.com/edib-tool/mix-edib",
        "Docs"   => "http://hexdocs.pm/edib",
        "About"  => "https://github.com/edib-tool/elixir-docker-image-builder"
      }
    ]
  end

  defp deps do
    [
      {:cmark, "~> 0.7", only: [:docs, :ci]},
      {:credo, "~> 0.8", only: [:lint, :ci]},
      {:espec, "~> 1.4", only: [:test, :ci]},
      {:ex_doc, "~> 0.16", only: [:dev, :docs, :ci]},
      {:excoveralls, "~> 0.7", only: [:test, :ci]},
      {:inch_ex, "~> 0.5", only: [:docs, :ci]},
      {:poison, "~> 3.1", only: [:test, :docs, :lint, :ci], override: true},
      {:dialyxir, "~> 0.5", only: [:dev]},
    ]
  end

  defp aliases do
    [
      "test": ["espec"]
    ]
  end
end

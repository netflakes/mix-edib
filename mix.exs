Code.eval_file "tasks/readme.exs"

defmodule EDIB.Mixfile do
  use Mix.Project

  @version "0.6.0-dev1"

  def project do
    [
      app:           :edib,
      name:          "edib",
      version:       @version,
      elixir:        "~> 1.2",
      deps:          deps,
      description:   description,
      package:       package,
      source_url:    "https://github.com/edib-tool/mix-edib",
      homepage_url:  "http://hexdocs.pm/mix-edib",
      docs:          &docs/0,
      test_coverage: [tool: ExCoveralls, test_task: "espec"],
    ]
  end

  def application, do: [applications: [:logger]]

  defp description do
    """
    Mix task to create a docker image of your application release.

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
        "GitHub": "https://github.com/edib-tool/mix-edib",
        "Docs":   "http://hexdocs.pm/edib",
        "About":  "https://github.com/edib-tool/elixir-docker-image-builder"
      }
    ]
  end

  defp deps do
    [
      {:cmark, "~> 0.6", only: [:docs]},
      {:credo, "~> 0.3.0-dev2", only: [:lint, :ci]},
      {:dogma, "~> 0.0.11", only: [:lint, :ci]},
      {:espec, "~> 0.8", only: [:dev, :test, :ci]},
      {:ex_doc, "~> 0.11", only: [:docs]},
      {:excoveralls, "~> 0.4", only: [:dev, :test, :ci]},
      {:inch_ex, "~> 0.5", only: [:ci]},
      {:poison, "~> 2.0", only: [:dev, :test, :lint, :ci], override: true}
    ]
  end
end

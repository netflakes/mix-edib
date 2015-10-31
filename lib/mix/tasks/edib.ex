defmodule Mix.Tasks.Edib do
  @moduledoc """
  EDIB creates a docker image of your application release.

  ## Install

  ### Project dependency

  In mix.exs:

      defp deps do
        [
          {:exrm, "~> 0.19"},
          {:edib, "~> 0.5.0"}
        ]
      end

  Then run:

      mix deps.get edib && mix deps.compile edib

  ### mix archive

  Just run this and confirm:

      mix archive.install http://git.io/edib-0.5.0.ez

  Adn don't forget to add `exrm` to your project:

      defp deps do
        [
          {:exrm, "~> 0.19"}
        ]
      end

  ## Usage

      mix edib

  ## Help

      mix help edib

  ## Options

      # Override the (repository) name of the docker image.
      mix edib --name <NAME>
      mix edib -n <NAME>

      # Set only a specific prefix for the docker image name (default: local).
      mix edib --prefix <PREFIX>
      mix edib -p <PREFIX>

      # Set a specific tag for the docker image.
      mix edib --tag <TAG>
      mix edib -t <TAG>

      # Silence build output of EDIB (will be logged to `.edib.log` instead).
      mix edib --silent
      mix edib -s

  If `--name` and `--prefix` are given, the name option takes precedence
  (prefix will be ignored).

      # Map additional volumes for use while building the release
      mix edib --mapping <FROM>:<TO>[:<OPTION>]
      mix edib -m <FROM>:<TO>[:<OPTION>]

  To pull dependencies stored in private github repositories you will need to
  make your SSH keys accessible from the container doing the build:

      mix edib --mapping /path/to/home/.ssh:/root/ssh.
  """

  @shortdoc "Create a Docker image of your app."

  use Mix.Task

  defdelegate run(args), to: Mix.Tasks.Edib.Image
end

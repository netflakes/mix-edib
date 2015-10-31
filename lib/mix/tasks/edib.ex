defmodule Mix.Tasks.Edib do
  @moduledoc """
  EDIB creates a docker image of your application release.

  ## Install

  ### mix archive

  Just run this and confirm:

      mix archive.install http://git.io/edib-0.5.0.ez

  And don't forget to add `exrm` to your project:

      defp deps do
        [
          {:exrm, "~> 0.19"}
        ]
      end

  ### Or as project dependency

  In mix.exs:

      defp deps do
        [
          {:exrm, "~> 0.19"},
          {:edib, "~> 0.5"}
        ]
      end

  Then run:

      mix deps.get edib && mix deps.compile edib

  ## Usage

      mix edib

  ## Help

      mix help edib

  ## Options

      # Override the (repository) name of the docker image
      mix edib --name <NAME>
      mix edib -n <NAME>

      # Set only a specific prefix for the docker image name (default: local)
      mix edib --prefix <PREFIX>
      mix edib -p <PREFIX>

      # Set a specific tag for the docker image
      mix edib --tag <TAG>
      mix edib -t <TAG>

      # Silence build output of EDIB (will be logged to `.edib.log` instead)
      mix edib --silent
      mix edib -s

  If `--name` and `--prefix` are given, the name option takes precedence
  (prefix will be ignored).

      # Map additional volumes for use while building the release
      mix edib --mapping <FROM>:<TO>[:<OPTION>]
      mix edib -m <FROM>:<TO>[:<OPTION>]

  For common cases there are some mapping shorthands:

      # Include the host user's SSH keys for private GitHub repositories:
      mix edib --ssh-keys

      # Include host user's .hex/packages cache
      #
      # Can improve build times when the host's .hex cache is available for
      # every build run (tip for Travis CI: use their directory caching)
      mix edib --hex

      # Include host user's .npm package cache
      #
      # Can improve build times when the host's .npm cache is available for
      # every build run (tip for Travis CI: use their directory caching)
      mix edib --npm

  Docker flags (mostly for debug purposes):

      # Run the build step privileged
      mix edib --privileged

      # Do not remove intermediate containers on build runs
      mix edib --no-rm

  """

  @shortdoc "Create a Docker image of your app."

  use Mix.Task

  defdelegate run(args), to: Mix.Tasks.Edib.Image
end

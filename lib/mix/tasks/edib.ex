defmodule Mix.Tasks.Edib do
  @moduledoc """
  EDIB creates a docker image of your application release.

  ## Installation

  Just run this and confirm:

      mix archive.install https://git.io/edib-0.6.1.ez

  Don't forget to add `exrm` to your project:

      defp deps do
        [
          {:exrm, "~> 1.0"},
        ]
      end

  ## Usage

      mix edib

  ## Help

      mix help edib

  ## Options

  ### Name, prefix, tag

  Override the (repository) name of the docker image

      mix edib --name <NAME>
      mix edib -n <NAME>

  Set only a specific prefix for the docker image name (default: local)

      mix edib --prefix <PREFIX>
      mix edib -p <PREFIX>

  Set a specific tag for the docker image

      mix edib --tag <TAG>
      mix edib -t <TAG>

  If `--name` and `--prefix` are given, the name option takes precedence
  (prefix will be ignored).

  ### Silent mode (quiet mode)

      # Silence build output of EDIB (will be logged to `.edib.log` instead)
      mix edib --silent
      mix edib -s

  ### Volume mappings

  Map additional volumes for use while building the release

      mix edib --mapping <FROM>:<TO>[:<OPTION>]
      mix edib -m <FROM>:<TO>[:<OPTION>]

  For common cases there are some mapping shorthands:

  Include the host user's SSH keys for private GitHub repositories

      mix edib --ssh-keys

  Include host user's .hex/packages cache

  Can improve build times when the host's .hex cache is available for
  every build run (tip for Travis CI: use their directory caching)

      mix edib --hex

  Include host user's .npm package cache

  Can improve build times when the host's .npm cache is available for
  every build run (tip for Travis CI: use their directory caching)

      mix edib --npm

  ### Docker related

  Docker flags (mostly for debug purposes):

  Run the build step privileged

      mix edib --privileged

  Do not remove intermediate containers on build runs

      mix edib --no-rm

  """

  @shortdoc "Create a Docker image of your app."

  use Mix.Task

  defdelegate run(args), to: Mix.Tasks.Edib.Image
end

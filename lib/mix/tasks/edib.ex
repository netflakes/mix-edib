defmodule Mix.Tasks.Edib do
  @moduledoc """
  EDIB creates a docker image of your application release.

  ## Installation

  Just run this and confirm:

      mix archive.install https://git.io/edib-0.10.0.ez

  Don't forget to add `distillery` to your project:

      defp deps do
        [
          {:distillery, "~> 1.1"},
        ]
      end

  ## Usage

      mix edib

  mix-edib will use the MIX_ENV environment variable to build the image.

      MIX_ENV=staging mix edib

  **WARNING:** If `MIX_ENV` is not set EDIB will build the image for the `prod` environment.

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

  ### Release strip and zip (EXPERIMENTAL)

  Following options use <https://github.com/ntrepid8/ex_strip_zip> in the
  edib-tool build environment.

  All .beam files in a release can be stripped (mostly of debug information):

      mix edib --strip
      mix edib -x

  More technical information about stripping:
  <http://erlang.org/doc/man/beam_lib.html#strip-1>

  All OTP applications can be bundled into archives (.ez files):

      mix edib --zip
      mix edib -z

  **WARNING:** Do not use this if you have NIFs in your codebase or dependencies.

  More technical information about "Loading of Code From Archive Files":
  <http://erlang.org/doc/man/code.html#id104826>

  ### Silent mode (quiet mode)

  Silence build output of EDIB (will be logged to `.edib.log` instead)

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

  ### Developer options

  Select edib-tool docker image (complete repo + version)

      mix edib --edib edib/edib-tool:1.5.2
      mix edib -e edib/edib-tool:1.5.2
  """

  @shortdoc "Create a Docker image of your app."

  use Mix.Task

  defdelegate run(args), to: Mix.Tasks.Edib.Image
end

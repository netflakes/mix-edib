defmodule EDIB.BuildConfig.Artifact do
  @moduledoc false

  alias EDIB.Defaults

  defstruct edib_tool:  Defaults.edib_tool,
            privileged: Defaults.docker_run_privileged,
            rm:         !Defaults.docker_run_no_rm,
            volumes:    [],
            settings:   [] # image settings (formerly RELEASE settings)

  def from_cli_options(options),
    do: EDIB.BuildConfig.Artifact.Parser.from_cli_options(options)

  def to_command(artifact_config),
    do: EDIB.BuildConfig.Artifact.Builder.build(artifact_config)
end

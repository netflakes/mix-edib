defmodule Edip.BuildConfig.Artifact do
  @moduledoc false

  alias Edip.Defaults

  defstruct edip_tool:  Defaults.edip_tool,
            privileged: Defaults.docker_run_privileged,
            rm:         !Defaults.docker_run_no_rm,
            volumes:    [],
            settings:   [] # image settings (formerly RELEASE settings)

  def from_cli_options(options),
    do: Edip.BuildConfig.Artifact.Parser.from_cli_options(options)
  def to_command(artifact_config),
    do: Edip.BuildConfig.Artifact.Builder.build(artifact_config)
end

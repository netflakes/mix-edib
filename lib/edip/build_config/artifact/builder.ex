defmodule Edip.BuildConfig.Artifact.Builder do
  @moduledoc false

  alias Edip.Defaults
  alias Edip.BuildConfig.Artifact.ImageSettings
  alias Edip.BuildConfig.Artifact.Volumes

  def build(artifact_config) do
    {:ok, artifact_config, []}
    |> set_edip_tool
    |> set_settings
    |> set_volumes
    |> set_docker_command
    |> return_command
  end

  ### Internals

  defp set_edip_tool({:ok, config, command_list}) do
    {:ok, config, [Defaults.edip_tool | command_list]}
  end
  defp set_edip_tool(error), do: error

  defp set_settings({:ok, %{settings: settings} = config, command_list}) do
    {:ok, config, [ImageSettings.to_docker_options(settings) | command_list]}
  end
  defp set_settings(error), do: error

  defp set_volumes({:ok, %{volumes: volumes} = config, command_list}) do
    {:ok, config, [Volumes.to_docker_options(volumes) | command_list]}
  end
  defp set_volumes(error), do: error

  defp set_docker_command({:ok, config, command_list}) do
    {:ok, config, [Defaults.docker_run | command_list]}
  end
  defp set_docker_command(error), do: error

  defp return_command({:ok, _, command_list}),
    do: {:ok, Enum.join(command_list, " ")}
  defp return_command(error),
    do: error

  [
    Defaults.docker_run,
    :volumes,
    :settings,
    :edip_tool
  ]
end

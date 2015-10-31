defmodule EDIB.BuildConfig.Artifact.Builder do
  @moduledoc false

  alias EDIB.Defaults
  alias EDIB.BuildConfig.Artifact.ImageSettings
  alias EDIB.BuildConfig.Artifact.Volumes

  def build(artifact_config) do
    {:ok, artifact_config, []}
    |> set_edib_tool
    |> set_settings
    |> set_volumes
    |> set_priv_flag
    |> set_rm_flag
    |> set_docker_command
    |> return_command
  end

  ### Internals

  defp set_edib_tool({:ok, config, command_list}) do
    {:ok, config, [Defaults.edib_tool | command_list]}
  end
  defp set_edib_tool(error), do: error

  defp set_settings({:ok, %{settings: settings} = config, command_list}) do
    {:ok, config, [ImageSettings.to_docker_options(settings) | command_list]}
  end
  defp set_settings(error), do: error

  defp set_volumes({:ok, %{volumes: volumes} = config, command_list}) do
    {:ok, config, [Volumes.to_docker_options(volumes) | command_list]}
  end
  defp set_volumes(error), do: error

  defp set_priv_flag({:ok, %{privileged: priv_flag} = config, command_list}) do
    {:ok, config, [ maybe_set_priv_flag(priv_flag) | command_list]}
  end
  defp set_priv_flag(error), do: error

  defp maybe_set_priv_flag(true), do: "--privileged"
  defp maybe_set_priv_flag(false), do: ""

  defp set_rm_flag({:ok, %{rm: rm_flag} = config, command_list}) do
    {:ok, config, [ maybe_set_rm_flag(rm_flag) | command_list]}
  end
  defp set_rm_flag(error), do: error

  defp maybe_set_rm_flag(true), do: "--rm"
  defp maybe_set_rm_flag(false), do: ""

  defp set_docker_command({:ok, config, command_list}) do
    {:ok, config, [Defaults.docker_run | command_list]}
  end
  defp set_docker_command(error), do: error

  defp return_command({:ok, _, command_list}),
    do: {:ok, Enum.join(command_list, " ")}
  defp return_command(error),
    do: error
end

defmodule Edip.BuildConfig.Artifact.Parser do
  @moduledoc false

  alias Edip.Defaults
  alias Edip.BuildConfig.Artifact
  alias Edip.BuildConfig.Artifact.Volume
  alias Edip.BuildConfig.Artifact.Volumes
  alias Edip.BuildConfig.Artifact.ImageSettings

  def from_cli_options(options) do
    {:ok, %Artifact{}, options}
    |> set_edip_tool
    |> set_custom_volumes
    |> ssh_keys_volume
    |> npm_packages_volume
    |> hex_packages_volume
    |> core_volumes
    |> set_image_settings
    |> set_rm_flag
    |> set_privileged_flag
    |> return_artifact_config
  end

  ### Internals

  defp set_edip_tool({:ok, artifact_config, options}) do
    edip_tool = Dict.get(options, :edip, Defaults.edip_tool)
    {:ok, %Artifact{ artifact_config | edip_tool: edip_tool }, options}
  end
  defp set_edip_tool(error), do: error

  defp set_custom_volumes({:ok, artifact_config, options}) do
    options
    |> Volumes.from_cli_options
    |> maybe_set_custom_volumes(artifact_config, options)
  end
  defp set_custom_volumes(error), do: error

  defp maybe_set_custom_volumes({:ok, volumes}, artifact_config, options),
    do: {:ok, %Artifact{ artifact_config | volumes: volumes }, options}
  defp maybe_set_custom_volumes(errors, _, _),
    do: errors

  defp ssh_keys_volume({:ok, artifact_config, options}) do
    with_ssh_volume = Dict.get(options, :ssh_keys, false)
    volumes         = add_ssh_volume(with_ssh_volume, artifact_config.volumes)
    {:ok, %Artifact{ artifact_config | volumes: volumes }, options}
  end
  defp ssh_keys_volume(error), do: error

  defp add_ssh_volume(true, volumes), do: [Volume.for_ssh_keys | volumes]
  defp add_ssh_volume(_, volumes),    do: volumes

  defp npm_packages_volume({:ok, artifact_config, options}) do
    with_npm_volume = Dict.get(options, :npm, false)
    volumes         = add_npm_volume(with_npm_volume, artifact_config.volumes)
    {:ok, %Artifact{ artifact_config | volumes: volumes }, options}
  end
  defp npm_packages_volume(error), do: error

  defp add_npm_volume(true, volumes), do: [Volume.for_npm_packages | volumes]
  defp add_npm_volume(_, volumes),    do: volumes

  defp hex_packages_volume({:ok, artifact_config, options}) do
    with_hex_volume = Dict.get(options, :hex, false)
    volumes         = add_hex_volume(with_hex_volume, artifact_config.volumes)
    {:ok, %Artifact{ artifact_config | volumes: volumes }, options}
  end
  defp hex_packages_volume(error), do: error

  defp add_hex_volume(true, volumes), do: [Volume.for_hex_packages | volumes]
  defp add_hex_volume(_, volumes),    do: volumes

  defp core_volumes({:ok, artifact_config, options}) do
    volumes = add_core_volumes(artifact_config.volumes)
    {:ok, %Artifact{ artifact_config | volumes: volumes }, options}
  end
  defp core_volumes(error), do: error

  defp add_core_volumes(volumes) do
    core_volumes = [
      Volume.for_source(Defaults.current_dir),
      Volume.for_tarball(Defaults.tarball_dir)
    ]
    core_volumes ++ volumes
  end

  defp set_image_settings({:ok, artifact_config, options}) do
    settings = ImageSettings.from_cli_options(options)
    {:ok, %Artifact{ artifact_config | settings: settings }, options}
  end
  defp set_image_settings(error), do: error

  defp set_rm_flag({:ok, artifact_config, options}) do
    rm = !Dict.get(options, :no_rm, Defaults.docker_run_no_rm)
    {:ok, %Artifact{ artifact_config | rm: rm }, options}
  end
  defp set_rm_flag(error), do: error

  defp set_privileged_flag({:ok, artifact_config, options}) do
    privileged = Dict.get(options, :privileged, Defaults.docker_run_privileged)
    {:ok, %Artifact{ artifact_config | privileged: privileged }, options}
  end
  defp set_privileged_flag(error), do: error

  defp return_artifact_config({:ok, artifact_config, _options}),
    do: {:ok, artifact_config}
  defp return_artifact_config(error),
    do: error
end

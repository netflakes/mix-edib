defmodule Edip.BuildConfig.Artifact.Volumes do
  @moduledoc false

  alias Edip.BuildConfig.Artifact.Volume

  def from_cli_options(options) do
    options
    |> Keyword.get_values(:volume)
    |> Enum.map(&Volume.from_cli_option/1)
    |> volumes_or_errors
  end

  def to_docker_options(volumes) do
    Enum.map_join(volumes, " ", &Volume.to_docker_option/1)
  end

  ### Internals

  defp volumes_or_errors(volumes) do
    volumes |> Dict.has_key?(:error) |> maybe_volumes_or_errors(volumes)
  end

  defp maybe_volumes_or_errors(false, volumes),
    do: {:ok, collect_volumes(volumes)}
  defp maybe_volumes_or_errors(true, volumes),
    do: {:error, collect_volume_errors(volumes)}

  defp collect_volumes(volumes), do: volumes |> Keyword.get_values(:ok)

  defp collect_volume_errors(volumes) do
    volumes
    |> Keyword.get_values(:error)
    |> Enum.join("\n")
  end
end

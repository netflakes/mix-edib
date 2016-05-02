defmodule EDIB.BuildConfig.Image.Builder do
  @moduledoc false

  use EDIB.Defaults
  alias EDIB.BuildConfig.Image

  def build(image_config) do
    image_config
    |> init_state
    |> image_build_command
    |> image_tag_command
    |> return_commands
  end

  ### Internals

  defp init_state(%Image{} = image_config),
    do: {:ok, image_config, []}
  defp init_state(_),
    do: {:error, "Invalid image config (not an Image struct)"}

  defp image_build_command({:ok, image_config, commands}) do
    tarball_command = tarball_command(image_config)
    docker_command = docker_import_command(image_config)
    command = ~s(#{tarball_command} | #{docker_command})
    {:ok, image_config, commands ++ [command]}
  end
  defp image_build_command(error),
    do: error

  defp tarball_command(image_config) do
    ~s(#{Defaults.tarball_command} #{image_config.tarball_dir}/#{image_config.tarball})
  end

  defp docker_import_command(image_config) do
    import_settings = parse_import_settings(image_config.settings)
    tagged_name = tagged_name(image_config)
    ~s(#{Defaults.docker_import} #{import_settings} - #{tagged_name})
  end

  defp parse_import_settings(settings) when is_list(settings),
    do: Enum.map_join(settings, " ", fn(line) -> ~s(--change '#{line}') end)
  defp parse_import_settings(settings) when is_binary(settings),
    do: settings
  defp parse_import_settings(_settings),
    do: ""

  defp tagged_name(image_config),
    do: ~s(#{image_config.name}:#{image_config.tag})

  defp image_tag_command({:ok, image_config, commands}) do
    tagged_name = tagged_name(image_config)
    latest = ~s(#{image_config.name}:latest)
    command = ~s(#{Defaults.docker_tag} #{tagged_name} #{latest})
    {:ok, image_config, commands ++ [command]}
  end
  defp image_tag_command(error),
    do: error

  defp return_commands({:ok, _image_config, commands}),
    do: {:ok, commands}
  defp return_commands(error),
    do: error
end

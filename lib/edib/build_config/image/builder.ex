defmodule EDIB.BuildConfig.Image.Builder do
  @moduledoc false

  @docker_import "docker import"
  @docker_tag    "docker tag --force"

  def build(image_config) do
    {:ok, image_config, []}
    |> image_build_command
    |> image_tag_command
    |> return_commands
  end

  ### Internals

  defp image_build_command({:ok, image_config, commands}) do
    tarball_command = tarball_command(image_config)
    docker_command  = docker_import_command(image_config)
    command         = ~s(#{tarball_command} | #{docker_command})
    {:ok, image_config, commands ++ [command]}
  end
  defp image_build_command(error), do: error

  defp tarball_command(image_config) do
    ~s(cat #{image_config.tarball_dir}/#{image_config.tarball})
  end

  defp docker_import_command(image_config) do
    import_settings = parse_import_settings(image_config.settings)
    tagged_name     = tagged_name(image_config)
    ~s(#{@docker_import} #{import_settings} - #{tagged_name})
  end

  defp parse_import_settings(settings) when is_list(settings) do
    settings
    |> Enum.map_join(" ", fn(line) -> ~s(--change '#{line}') end)
  end
  defp parse_import_settings(settings) when is_binary(settings),
    do: settings
  defp parse_import_settings(_settings),
    do: ""

  defp tagged_name(image_config) do
    ~s(#{image_config.name}:#{image_config.tag})
  end

  defp image_tag_command({:ok, image_config, commands}) do
    tagged_name = tagged_name(image_config)
    latest      = ~s(#{image_config.name}:latest)
    command     = ~s(#{@docker_tag} #{tagged_name} #{latest})
    {:ok, image_config, commands ++ [command]}
  end
  defp image_tag_command(error), do: error

  defp return_commands({:ok, _image_config, commands}),
    do: {:ok, commands}
  defp return_commands(error),
    do: error
end

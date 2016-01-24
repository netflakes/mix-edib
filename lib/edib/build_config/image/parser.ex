defmodule EDIB.BuildConfig.Image.Parser do
  @moduledoc false

  alias EDIB.BuildConfig.Image

  def parse_file(config_file) do
    config_file
    |> file_content
    |> maybe_parse_file(config_file)
  end

  ### Internals

  defp maybe_parse_file({:ok, content}, config_file),
    do: parse_content(content, config_file)
  defp maybe_parse_file(error, _),
    do: error

  defp parse_content(config_data, config_file_location),
    do: parse({%Image{}, config_data}, config_file_location)

  defp parse({_, _} = config_tuple, config_file_location) do
    config_tuple
    |> tarball_directory(config_file_location)
    |> transform_data_to_lines
    |> parse_config_lines
    |> tarball_exists?
  end

  defp file_content(config_file),
    do: config_file |> read_file("image config file")

  defp read_file(file, file_type),
    do: file |> File.read |> maybe_read_file_data(file, file_type)

  defp maybe_read_file_data({:ok, _} = ok_data, _, _),
    do: ok_data
  defp maybe_read_file_data({:error, _}, file, file_type),
    do: {:error, "Could not read #{file_type}: #{file}"}

  defp tarball_directory({image_config, config_data}, path) do
    {
      struct(image_config, tarball_dir: absolute_dirname(path)),
      config_data
    }
  end

  defp absolute_dirname(directory),
    do: directory |> Path.dirname |> Path.absname

  defp transform_data_to_lines({image_config, config_data}) do
    config_data
    |> content_to_lines
    |> consolidate_transformation(image_config)
  end

  defp consolidate_transformation({:ok, lines}, image_config),
    do: {:ok, image_config, lines}

  defp content_to_lines(config_data),
    do: {:ok, config_data} |> maybe_to_lines

  defp maybe_to_lines({:ok, content}),
    do: {:ok, content |> to_lines}
  defp maybe_to_lines(error),
    do: error

  def to_lines(content) do
    content
    |> String.split("\n")
    |> Stream.map(&String.strip/1)
    |> Enum.filter(&empty_line_filter/1)
  end

  defp empty_line_filter(line),
    do: (line != "" && line != nil)

  defp parse_config_lines({:ok, image_config, config_lines}),
    do: Enum.reduce(config_lines, {:ok, image_config}, &line_reducer/2)

  defp line_reducer(line, {:ok, image_config}),
    do: parse_line(line, image_config)

  defp parse_line("TARBALL_FILE " <> tarball_file, image_config),
    do: {:ok, struct(image_config, tarball: tarball_file)}
  defp parse_line("IMAGE_NAME " <> name, image_config),
    do: {:ok, struct(image_config, name: name)}
  defp parse_line("IMAGE_TAG " <> tag, image_config),
    do: {:ok, struct(image_config, tag: tag)}
  defp parse_line("IMAGE_SETTINGS !" <> settings_file, image_config) do
    image_config.tarball_dir
    |> parse_settings(settings_file)
    |> maybe_parse_image_settings(image_config)
  end
  defp parse_line("IMAGE_SETTINGS " <> settings, image_config),
    do: {:ok, struct(image_config, settings: settings)}
  defp parse_line(_unknown, image_config),
    do: {:ok, image_config}

  defp parse_settings(tarball_dir, settings_file) do
    settings_file
    |> Path.expand(tarball_dir)
    |> read_lines("image settings configuration file")
    |> skip_lines
  end

  defp maybe_parse_image_settings({:ok, setting_lines}, image_config),
    do: {:ok, struct(image_config, settings: setting_lines)}
  defp maybe_parse_image_settings(error, _),
    do: error

  defp read_lines(file, file_type),
    do: file |> read_file(file_type) |> maybe_to_lines

  defp skip_lines({:ok, setting_lines}) do
    filtered_lines =
      Enum.filter_map(setting_lines, &empty_line_filter/1, &skip_line/1)
    {:ok, filtered_lines}
  end
  defp skip_lines(error),
    do: error

  defp skip_line("FROM" <> _rest),
    do: nil
  defp skip_line(line),
    do: line

  defp tarball_exists?({:ok, image_config}) do
    image_config
    |> tarball_filename
    |> tarball_file_exists?
  end
  defp tarball_exists?(error),
    do: error

  defp tarball_filename(%{tarball: nil} = image_config),
    do: {:error, "No tarball file name present in artifact.cfg", image_config}
  defp tarball_filename(%{tarball: tar, tarball_dir: directory} = config),
    do: {:ok, directory <> "/" <> tar, config}

  defp tarball_file_exists?({:ok, tarball_filename, image_config}) do
    tarball_filename
    |> File.exists?
    |> maybe_file_exists(tarball_filename, image_config)
  end
  defp tarball_file_exists?(error),
    do: error

  defp maybe_file_exists(true, _, image_config),
    do: {:ok, image_config}
  defp maybe_file_exists(_, tarball_filename, _),
    do: {:error, "Tarball file not found: #{tarball_filename}"}
end

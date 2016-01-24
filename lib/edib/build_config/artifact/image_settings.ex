defmodule EDIB.BuildConfig.Artifact.ImageSettings do
  @moduledoc false

  def from_cli_options(options) do
    {options, []}
    |> package_name
    |> package_tag
    |> package_prefix
    |> with_test_run
    |> elem(1)
  end

  def to_docker_options(image_settings) do
    Enum.map_join(image_settings, " ", &to_docker_option/1)
  end

  ### Internals

  defp to_docker_option(setting) do
    ~s(-e "#{setting}")
  end

  defp package_name({%{name: name} = options, vars}),
    do: maybe_package_name(name, options, vars)
  defp package_name({options, vars}),
    do: {options, vars}

  defp maybe_package_name(nil, options, vars),
    do: {options, vars}
  defp maybe_package_name(name, options, vars),
    do: {options, ["RELEASE_NAME=#{name}" | vars]}

  defp package_tag({%{tag: tag} = options, vars}),
    do: maybe_package_tag(tag, options, vars)
  defp package_tag({options, vars}),
    do: {options, vars}

  defp maybe_package_tag(nil, options, vars),
    do: {options, vars}
  defp maybe_package_tag(tag, options, vars),
    do: {options, ["RELEASE_TAG=#{tag}" | vars]}

  defp package_prefix({%{prefix: prefix} = options, vars}),
    do: maybe_package_prefix(prefix, options, vars)
  defp package_prefix({options, vars}),
    do: {options, vars}

  defp maybe_package_prefix(nil, options, vars),
    do: {options, vars}
  defp maybe_package_prefix(prefix, options, vars),
    do: {options, ["RELEASE_PREFIX=#{prefix}" | vars]}

  defp with_test_run({%{test: test} = options, vars}),
    do: maybe_with_test_run(test, options, vars)
  defp with_test_run({options, vars}),
    do: {options, vars}

  defp maybe_with_test_run(true, options, vars),
    do: {options, ["TEST=true" | vars]}
  defp maybe_with_test_run(_, options, vars),
    do: {options, vars}
end

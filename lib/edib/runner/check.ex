defmodule EDIB.Runner.Check do
  @moduledoc false

  def prerequisites({:ok, _, _} = state),
    do: state |> check_app |> check_distillery
  def prerequisites(error),
    do: error

  ### Internals

  defp check_app({:ok, _msg, options}),
    do: project? |> maybe_check_app(options)
  defp check_app(error),
    do: error

  defp maybe_check_app(nil, options) do
    {
      :error,
      "No Mix project in this directory! " <>
      "Please ensure a mix.exs file is available.",
      options
    }
  end
  defp maybe_check_app(_, options),
    do: {:ok, :project_present, options}

  defp check_distillery({:ok, _msg, options}),
    do: distillery? |> maybe_check_distillery(options)
  defp check_distillery(error),
    do: error

  defp maybe_check_distillery(true, options),
    do: {:ok, :project_present, options}
  defp maybe_check_distillery(_, options) do
    {
      :error,
      "No `distillery` dependency found. Please add it to your project.",
      options
    }
  end

  defp project?,       do: Mix.Project.get
  defp distillery?,    do: project_deps |> Keyword.has_key?(:distillery)
  defp project_deps,   do: project_config |> Keyword.get(:deps)
  defp project_config, do: Mix.Project.config
end

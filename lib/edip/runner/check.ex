defmodule Edip.Runner.Check do
  @moduledoc false

  def prerequisites({:ok, _, _} = state),
    do: state |> check_app |> check_exrm
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

  defp check_exrm({:ok, _msg, options}),
    do: exrm? |> maybe_check_exrm(options)
  defp check_exrm(error),
    do: error

  defp maybe_check_exrm(true, options),
    do: {:ok, :project_present, options}
  defp maybe_check_exrm(_, options) do
    {
      :error,
      "No `exrm` dependency found. Please add it to your project.",
      options
    }
  end

  defp project?,       do: Mix.Project.get
  defp exrm?,          do: project_deps |> Dict.has_key?(:exrm)
  defp project_deps,   do: project_config |> Dict.get(:deps)
  defp project_config, do: Mix.Project.config
end

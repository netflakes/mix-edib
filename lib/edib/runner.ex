defmodule EDIB.Runner do
  @moduledoc false

  import EDIB.Utils

  def run(cli_arguments) when is_list(cli_arguments) do
    notice("Will use EDIB tool v#{EDIB.Defaults.edib_version}")
    run_steps(cli_arguments)
  end
  def run(cli_arguments) do
    {
      :error,
      "Given arguments are not valid (not a list) => #{inspect cli_arguments}",
      :oops
    }
    |> success_or_error!
  end

  defp run_steps(cli_arguments) do
    cli_arguments
    |> EDIB.Options.from_cli_arguments
    |> check_options
    |> EDIB.Runner.Check.prerequisites
    |> EDIB.Runner.Log.reinit
    |> package_processing_info
    |> EDIB.Runner.ArtifactBuilder.run
    |> EDIB.Runner.ImageBuilder.run
    |> success_or_error!
  end

  defp check_options({:ok, options}), do: {:ok, :options_ok, options}
  defp check_options({:error, msg}),  do: {:error, msg, :invalid_options}

  defp package_processing_info({:ok, _, _} = state) do
    info("Packaging your app release into a docker image. Stay tuned!")
    state
  end
  defp package_processing_info(error), do: error

  defp success_or_error!({:ok, _, _}) do
    info("Packaging was successful! \\o/")
    :ok
  end
  defp success_or_error!({:error, msg, _}) do
    error("An error happened!")
    error("Reason: #{msg}")
    abort!
  end
end

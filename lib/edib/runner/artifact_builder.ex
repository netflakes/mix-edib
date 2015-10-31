defmodule EDIB.Runner.ArtifactBuilder do
  @moduledoc false

  import EDIB.Utils
  alias EDIB.BuildConfig.Artifact

  def run({:ok, _, options}) do
    {:ok, :init_artifact_build, options}
    |> to_command
    |> print_info("Creating artifact (might take a while) ...")
    |> run_command
  end
  def run(error), do: error

  ### Internals

  defp to_command({:ok, _msg, %{artifact_config: config} = options}) do
    config
    |> Artifact.to_command
    |> maybe_to_command(options)
  end
  defp to_command(error), do: error

  defp maybe_to_command({:ok, command}, options) do
    options.writer.("$> #{command}\n")
    {:ok, :to_command, {command, options}}
  end
  defp maybe_to_command(_, _) do
    {:error, "Error while parsing options to build command", :invalid_command}
  end

  defp run_command({:ok, _msg, {command, options}}) do
    command
    |> do_cmd(options.writer)
    |> after_run_command(options)
  end
  defp run_command(error), do: error

  defp after_run_command(0, options) do
    info("Artifact successfully created.")
    {:ok, :artifact_created, options}
  end
  defp after_run_command(_, options) do
    {
      :error,
      "Artifact tarball not created! Check for any errors above.",
      options
    }
  end
end

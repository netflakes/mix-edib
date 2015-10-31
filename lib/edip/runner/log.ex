defmodule Edip.Runner.Log do
  @moduledoc false

  def reinit({:ok, _msg, options}) do
    {:ok, :reinit_log, options}
    |> delete_file
    |> add_header
  end
  def reinit(error), do: error

  def delete_file({:ok, _msg, %{silent: false} = options}),
    do: {:ok, :skip_log_deletion, options}
  def delete_file({:ok, _msg, options}) do
    Edip.Utils.LogWriter.log_file
    |> File.rm_rf
    |> maybe_delete_file(options)
  end
  def delete_file(error), do: error

  defp maybe_delete_file({:ok, _}, options),
    do: {:ok, :log_file_deleted, options}
  defp maybe_delete_file({:error, _, _}, options),
    do: {:ok, :append_to_existing_log, options}

  def add_header({:ok, _msg, %{silent: false} = options}),
    do: {:ok, :skip_log_header, options}
  def add_header({:ok, _msg, options}) do
    header = """
    EDIP tool v#{Edip.Defaults.edip_version}
    DT(UTC): #{inspect :calendar.universal_time}
    ==================================================

    """
    Edip.Utils.LogWriter.write(header)

    {:ok, :log_header_added, options}
  end
  def add_header(error), do: error
end

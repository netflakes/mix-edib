defmodule EDIB.Utils.LogWriter do
  @moduledoc false

  def write(data), do: File.write(log_file(), data, [:append])

  def log_file, do: System.cwd! <> "/.edib.log"
end

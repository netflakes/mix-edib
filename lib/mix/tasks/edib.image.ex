defmodule Mix.Tasks.Edib.Image do
  @moduledoc false

  use Mix.Task

  @doc false
  defdelegate run(args), to: EDIB.Runner
end

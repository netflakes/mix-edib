defmodule Mix.Tasks.Edib.Image do
  @moduledoc false

  use Mix.Task

  defdelegate run(args), to: EDIB.Runner
end

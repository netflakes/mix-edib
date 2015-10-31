defmodule Mix.Tasks.Edip.Image do
  @moduledoc false

  use Mix.Task

  defdelegate run(args), to: Edip.Runner
end

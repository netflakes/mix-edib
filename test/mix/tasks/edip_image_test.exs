defmodule MixTasksEdipImageTest do
  use Pavlov.Case
  import Pavlov.Syntax.Expect

  describe "Mix.Tasks.Edip.Image" do
    describe "run/1" do
      before :each do
        allow(Edip.Runner, [:no_link, :passthrough])
        |> to_receive(run: fn(_) -> :passed end)
        :ok
      end

      it "delegates call to Edip.Runner.run/1" do
        expect Mix.Tasks.Edip.Image.run(:arguments) |> to_eq(:passed)
      end
    end
  end
end

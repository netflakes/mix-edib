defmodule MixTasksEDIBImageTest do
  use Pavlov.Case
  import Pavlov.Syntax.Expect

  describe "Mix.Tasks.Edib.Image" do
    describe "run/1" do
      before :each do
        allow(EDIB.Runner, [:no_link, :passthrough])
        |> to_receive(run: fn(_) -> :passed end)
        :ok
      end

      it "delegates call to EDIB.Runner.run/1" do
        expect Mix.Tasks.Edib.Image.run(:arguments) |> to_eq(:passed)
      end
    end
  end
end

defmodule MixTasksEDIBTest do
  use Pavlov.Case
  import Pavlov.Syntax.Expect

  describe "Mix.Tasks.Edib" do
    describe "run/1" do
      context "delegation to Image subtask" do
        before :each do
          Mix.Tasks.Edib.Image
          |> allow([:no_link, :passthrough])
          |> to_receive(run: fn(_) -> :passed end)
          :ok
        end

        it "delegates call to Mix.Tasks.Edib.Image.run/1" do
          expect Mix.Tasks.Edib.run(:arguments) |> to_eq(:passed)
        end
      end

      context "redirection to EDIB.Runner" do
        before :each do
          EDIB.Runner
          |> allow([:no_link, :passthrough])
          |> to_receive(run: fn(_) -> :redirect_passed end)
          :ok
        end

        it "redirects to EDIB.Runner.run/1 actually" do
          expect Mix.Tasks.Edib.run(:arguments) |> to_eq(:redirect_passed)
        end
      end
    end
  end
end

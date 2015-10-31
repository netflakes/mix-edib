defmodule MixTasksEdipTest do
  use Pavlov.Case
  import Pavlov.Syntax.Expect

  describe "Mix.Tasks.Edip" do
    describe "run/1" do
      context "delegation to Image subtask" do
        before :each do
          Mix.Tasks.Edip.Image
          |> allow([:no_link, :passthrough])
          |> to_receive(run: fn(_) -> :passed end)
          :ok
        end

        it "delegates call to Mix.Tasks.Edip.Image.run/1" do
          expect Mix.Tasks.Edip.run(:arguments) |> to_eq(:passed)
        end
      end

      context "redirection to Edip.Runner" do
        before :each do
          Edip.Runner
          |> allow([:no_link, :passthrough])
          |> to_receive(run: fn(_) -> :redirect_passed end)
          :ok
        end

        it "redirects to Edip.Runner.run/1 actually" do
          expect Mix.Tasks.Edip.run(:arguments) |> to_eq(:redirect_passed)
        end
      end
    end
  end
end

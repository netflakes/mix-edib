defmodule MixTasksEdibImageSpec do
  use ESpec
  alias EDIB.Runner
  alias Mix.Tasks.Edib.Image

  describe "Mix.Tasks.Edib.Image" do
    describe "run/1" do
      before do
        allow(Runner).to accept(:run, fn(_) -> :passed end)
      end

      it "delegates to EDIB.Runner.run/1" do
        expect(Image.run(:arguments)).to eql(:passed)
      end
    end
  end
end

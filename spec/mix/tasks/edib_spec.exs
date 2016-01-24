defmodule MixTasksEdibSpec do
  use ESpec
  alias Mix.Tasks.Edib
  alias Mix.Tasks.Edib.Image

  describe "Mix.Tasks.Edib" do
    describe "run/1" do
      before do
        allow(Image).to accept(:run, fn(_) -> :passed end)
      end

      it "delegates to Mix.Tasks.Edib.Image.run/1" do
        expect(Edib.run(:arguments)).to eql(:passed)
      end
    end
  end
end

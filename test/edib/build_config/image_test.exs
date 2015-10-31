defmodule EDIBBuildConfigImageTest do
  use Pavlov.Case
  import Pavlov.Syntax.Expect

  describe "EDIB.BuildConfig.Image" do
    describe "from_config_file/1" do
      let :expected_result, do: {:ok, "passed!"}

      before :each do
        allow(EDIB.BuildConfig.Image.Parser, [:no_link, :passthrough])
        |> to_receive(parse_file: fn(_) -> expected_result end)
        :ok
      end

      it "calls the image config file parser" do
        result = EDIB.BuildConfig.Image.from_config_file([])
        expect result |> to_eq expected_result
      end
    end

    describe "to_commands/1" do
      let :expected_result, do: {:ok, "passed!"}

      before :each do
        allow(EDIB.BuildConfig.Image.Builder, [:no_link, :passthrough])
        |> to_receive(build: fn(_) -> expected_result end)
        :ok
      end

      it "calls the image command builder" do
        result = EDIB.BuildConfig.Image.to_commands(%{})
        expect result |> to_eq expected_result
      end
    end
  end
end

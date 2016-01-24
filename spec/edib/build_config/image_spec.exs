defmodule EDIBBuildConfigImageTest do
  use ESpec
  alias EDIB.BuildConfig.Image
  alias EDIB.BuildConfig.Image.{Builder, Parser}

  describe "EDIB.BuildConfig.Image" do
    let! :expected_result, do: {:ok, "passed!"}

    describe "from_config_file/1" do
      before do
        allow(Parser).to accept(:parse_file, fn(_) -> expected_result end)
      end

      it "calls the image config file parser" do
        result = Image.from_config_file([])
        expect(result).to eql(expected_result)
      end
    end

    describe "to_commands/1" do
      before do
        allow(Builder).to accept(:build, fn(_) -> expected_result end)
      end

      it "calls the image command builder" do
        result = Image.to_commands(%{})
        expect(result).to eql(expected_result)
      end
    end
  end
end

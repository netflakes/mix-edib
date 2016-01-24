defmodule EDIBBuildConfigArtifactSpec do
  use ESpec
  alias EDIB.BuildConfig.Artifact
  alias EDIB.BuildConfig.Artifact.{Builder, Parser}

  describe "EDIB.BuildConfig.Artifact" do
    let! :expected_result, do: {:ok, "passed!"}

    describe "from_cli_options/1" do
      before do
        allow(Parser).to accept(:from_cli_options, fn(_) -> expected_result end)
      end

      it "calls the artifact config parser" do
        result = Artifact.from_cli_options([])
        expect(result).to eql(expected_result)
      end
    end

    describe "to_command/1" do
      before do
        allow(Builder).to accept(:build, fn(_) -> expected_result end)
      end

      it "calls the artifact command builder" do
        result = Artifact.to_command(%{})
        expect(result).to eql(expected_result)
      end
    end
  end
end

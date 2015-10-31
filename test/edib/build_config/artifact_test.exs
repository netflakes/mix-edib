defmodule EDIBBuildConfigArtifactTest do
  use Pavlov.Case
  import Pavlov.Syntax.Expect

  describe "EDIB.BuildConfig.Artifact" do
    describe "from_cli_options/1" do
      let :expected_result, do: {:ok, "passed!"}

      before :each do
        EDIB.BuildConfig.Artifact.Parser
        |> allow([:no_link, :passthrough])
        |> to_receive(from_cli_options: fn(_) -> expected_result end)
        :ok
      end

      it "calls the artifact config parser" do
        result = EDIB.BuildConfig.Artifact.from_cli_options([])
        expect result |> to_eq expected_result
      end
    end

    describe "to_command/1" do
      let :expected_result, do: {:ok, "passed!"}

      before :each do
        EDIB.BuildConfig.Artifact.Builder
        |> allow([:no_link, :passthrough])
        |> to_receive(build: fn(_) -> expected_result end)
        :ok
      end

      it "calls the artifact command builder" do
        result = EDIB.BuildConfig.Artifact.to_command(%{})
        expect result |> to_eq expected_result
      end
    end
  end
end

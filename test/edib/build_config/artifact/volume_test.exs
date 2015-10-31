defmodule EDIBBuildConfigArtifactVolumeTest do
  use Pavlov.Case
  # import Pavlov.Syntax.Expect

  describe "EDIB.BuildConfig.Artifact.Volume" do
    # describe "new/2" do
    #   before :each do
    #     allow(EDIB.BuildConfig.Artifact.Volume, [:no_link, :passthrough])
    #     |> to_receive(new: fn(from, to, perms) -> :passed end)
    #     :ok
    #   end
    #
    #   it "calls new/3 with default permissions (ro)" do
    #     expect EDIB.BuildConfig.Artifact.Volume.new(:from, :to) |> to_eq :passed
    #   end
    # end
    #
    # describe "new/3" do
    #   :ok
    # end

    describe "for_source/1" do
      it "works" do
        # ...
      end
    end

    describe "for_tarball/1" do
      :ok
    end

    describe "for_ssh_keys/0" do
      :ok
    end

    describe "for_hex_packages/0" do
      :ok
    end

    describe "from_cli_option/1" do
      :ok
    end

    describe "to_docker_option/1" do
      :ok
    end
  end
end

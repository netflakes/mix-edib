defmodule EDIBBuildConfigArtifactParserSpec do
  use ESpec
  alias EDIB.BuildConfig.Artifact
  alias EDIB.BuildConfig.Artifact.{Parser, Volume}
  alias EDIB.Defaults

  describe "EDIB.BuildConfig.Artifact.Parser" do
    describe "from_cli_options/1" do
      context "empty options" do
        let :default_artifact_config do
          %Artifact{
            volumes: [
              Volume.for_source(Defaults.current_dir),
              Volume.for_tarball(Defaults.tarball_dir),
            ]
          }
        end

        it "returns default artifact config" do
          {result, artifact_config} = Parser.from_cli_options([])
          expect(result).to eql(:ok)
          expect(artifact_config).to be_struct(Artifact)
          expect(artifact_config).to eq(default_artifact_config)
        end
      end

      context "custom options" do
        context "for edib tool (docker image)" do
          xit do: :ok
        end

        context "for custom volumes" do
          xit do: :ok
        end

        context "for ssh keys" do
          xit do: :ok
        end

        context "for npm package cache" do
          xit do: :ok
        end

        context "for hex package cache" do
          xit do: :ok
        end

        context "for image settings" do
          xit do: :ok
        end

        context "for rm flag" do
          xit do: :ok
        end

        context "for privileged flag" do
          xit do: :ok
        end
      end

      context "invalid options" do
        context "invalid option list" do
          it "fails with error" do
            {result, message} = Parser.from_cli_options(:invalid_options)
            expect(result).to eql(:error)
            expect(message).to eql("Invalid options given (not a list/dict/map)")
          end
        end

        context "invalid volume" do
          let :invalid_volume_option, do: "i_am_so_alone"

          it "fails with error" do
            {result, message} = Parser.from_cli_options([volume: invalid_volume_option])
            expect(result).to eql(:error)
            expect(message).to eql("Given volume option is not valid: #{invalid_volume_option}")
          end
        end
      end
    end
  end
end

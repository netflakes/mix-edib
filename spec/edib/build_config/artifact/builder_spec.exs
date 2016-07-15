defmodule EDIBBuildConfigArtifactBuilderSpec do
  use ESpec
  alias EDIB.BuildConfig.Artifact
  alias EDIB.BuildConfig.Artifact.{Builder, ImageSettings, Volume}
  alias EDIB.Defaults

  describe "EDIB.BuildConfig.Artifact.Builder" do
    describe "build/1" do
      let :rm_flag, do: "--rm"
      let :privileged_flag, do: "--privileged"
      let :environment_flag, do: "-e MIX_ENV="

      context "defaults ('unconfigured' state)" do
        let :default_config, do: %Artifact{}

        it "returns a default command string" do
          {result, command_string} = Builder.build(default_config)
          expect(result).to eql(:ok)
          expect(command_string).to have(Defaults.docker_run)
          expect(command_string).to have(rm_flag)
          expect(command_string).to have(Defaults.edib_tool)
          expect(command_string).to have(environment_flag <> Defaults.environment)
        end
      end

      context "with given image settings" do
        let :setting, do: "NAME=test-name"
        let :settings, do: [setting]
        let :docker_setting, do: ImageSettings.to_docker_options(settings)
        let :config, do: %Artifact{settings: settings}

        it "returns a command string" do
          {result, command_string} = Builder.build(config)
          expect(result).to eql(:ok)
          expect(command_string).to have(docker_setting)
        end
      end

      context "with given volumes" do
        let :volume, do: Volume.for_ssh_keys
        let :docker_mapping, do: Volume.to_docker_option(volume)
        let :config, do: %Artifact{volumes: [volume]}

        it "returns a command string" do
          {result, command_string} = Builder.build(config)
          expect(result).to eql(:ok)
          expect(command_string).to have(docker_mapping)
        end
      end

      context "with --privileged flag enabled" do
        let :config, do: %Artifact{privileged: true}

        it "returns a command string" do
          {result, command_string} = Builder.build(config)
          expect(result).to eql(:ok)
          expect(command_string).to have(privileged_flag)
        end
      end

      context "with --rm flag disabled" do
        let :config, do: %Artifact{rm: false}

        it "returns a command string" do
          {result, command_string} = Builder.build(config)
          expect(result).to eql(:ok)
          expect(command_string).to_not have(rm_flag)
        end
      end

      context "invalid artifact config" do
        it "returns an error" do
          {result, message} = Builder.build(%{info: "this is an invalid config"})
          expect(result).to eql(:error)
          expect(message).to eql("Not a valid artifact config given")
        end
      end
    end
  end
end

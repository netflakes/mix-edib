defmodule EDIBBuildConfigArtifactImageSettingsSpec do
  use ESpec
  alias EDIB.BuildConfig.Artifact.ImageSettings

  describe "EDIB.BuildConfig.Artifact.ImageSettings" do
    describe "from_cli_options/1" do
      context "empty options" do
        it "returns an empty list" do
          result = ImageSettings.from_cli_options(%{})
          expect(result).to eql([])
        end
      end

      context "for package name" do
        let :options, do: %{name: "test-name"}

        it "returns list containing name option" do
          result = ImageSettings.from_cli_options(options)
          expect(result).to eql(["RELEASE_NAME=#{options.name}"])
        end
      end

      context "for package tag" do
        let :options, do: %{tag: "test-tag"}

        it "returns list containing tag option" do
          result = ImageSettings.from_cli_options(options)
          expect(result).to eql(["RELEASE_TAG=#{options.tag}"])
        end
      end

      context "for package prefix" do
        let :options, do: %{prefix: "test-prefix"}

        it "returns list containing prefix option" do
          result = ImageSettings.from_cli_options(options)
          expect(result).to eql(["RELEASE_PREFIX=#{options.prefix}"])
        end
      end

      context "for release strip" do
        let :options, do: %{strip: true}

        it "returns list containing release strip option" do
          result = ImageSettings.from_cli_options(options)
          expect(result).to eql(["RELEASE_STRIP=true"])
        end
      end

      context "for release zip" do
        let :options, do: %{zip: true}

        it "returns list containing release zip option" do
          result = ImageSettings.from_cli_options(options)
          expect(result).to eql(["RELEASE_ZIP=true"])
        end
      end

      context "for test run" do
        let :options, do: %{test: true}

        it "returns list containing test run option" do
          result = ImageSettings.from_cli_options(options)
          expect(result).to eql(["TEST=true"])
        end
      end
    end

    describe "to_docker_options/1" do
      let :settings, do: ~w(foo bar baz)

      it "returns a docker options string" do
        result = ImageSettings.to_docker_options(settings)
        expect(result).to eql(~s(-e "foo" -e "bar" -e "baz"))
      end
    end
  end
end

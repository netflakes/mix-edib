defmodule EDIBBuildConfigImageBuilderTest do
  use ESpec
  alias EDIB.BuildConfig.Image
  alias EDIB.BuildConfig.Image.Builder

  describe "EDIB.BuildConfig.Image.Builder" do
    describe "build/1" do
      context "valid config" do
        let :tarball_dir, do: "/tarball/dir"
        let :tarball, do: "test-tarball.tar"
        let :name, do: "test-name"
        let :tag, do: "test-tag"

        let :image_config do
          %Image{
            tarball_dir: tarball_dir,
            tarball: tarball,
            name: name,
            tag: tag,
            settings: settings
          }
        end

        let :cat_command,
          do: "cat #{tarball_dir}/#{tarball}"
        let :import_command,
          do: "docker import #{output_settings} - #{name}:#{tag}"
        let :cat_and_import,
          do: "#{cat_command} | #{import_command}"
        let :tag_command,
          do: "docker tag --force #{name}:#{tag} #{name}:latest"

        context "settings as string" do
          let :settings, do: "test-settings"
          let :output_settings, do: settings

          it "returns command list" do
            {result, commands} = Builder.build(image_config)
            expect(result).to eql(:ok)
            expect(commands).to have(cat_and_import)
            expect(commands).to have(tag_command)
          end
        end

        context "settings as list" do
          let :settings, do: ["a-test-setting"]
          let :output_settings, do: ~s(--change '#{hd(settings)}')

          it "returns command list" do
            {result, commands} = Builder.build(image_config)
            expect(result).to eql(:ok)
            expect(commands).to have(cat_and_import)
            expect(commands).to have(tag_command)
          end
        end
      end

      context "invalid config" do
        it "fails with error" do
          {result, message} = Builder.build(%{})
          expect(result).to eql(:error)
          expect(message).to eql("Invalid image config (not an Image struct)")
        end
      end
    end
  end
end

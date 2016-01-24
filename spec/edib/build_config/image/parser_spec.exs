defmodule EDIBBuildConfigImageParserTest do
  use ESpec
  alias EDIB.BuildConfig.Image
  alias EDIB.BuildConfig.Image.Parser

  describe "EDIB.BuildConfig.Image.Parser" do
    describe "parse_file/1" do
      context "standard config" do
        let :cfg_file, do: "spec/fixtures/artifact.cfg"

        it "returns image config" do
          {result, config} = Parser.parse_file(cfg_file)
          expect(result).to eql(:ok)
          expect(config).to be_struct(Image)
        end
      end

      context "settings as file" do
        context "valid settings file" do
          let :cfg_file, do: "spec/fixtures/artifact.with_settings_file.cfg"

          it "returns image config" do
            {result, config} = Parser.parse_file(cfg_file)
            expect(result).to eql(:ok)
            expect(config).to be_struct(Image)
          end
        end

        context "file not found" do
          let :cfg_file, do: "spec/fixtures/artifact.with_broken_file.cfg"

          it "fails with error" do
            {result, message} = Parser.parse_file(cfg_file)
            expect(result).to eql(:error)
            expect(message).to have("Could not read image settings configuration file:")
          end
        end
      end

      context "tarball file" do
        context "no tarball given" do
          let :cfg_file, do: "spec/fixtures/artifact.with_no_tarball.cfg"

          it "fails with error" do
            {result, message, _cfg} = Parser.parse_file(cfg_file)
            expect(result).to eql(:error)
            expect(message).to have("No tarball file name present in artifact.cfg")
          end
        end

        context "missing tarball" do
          let :cfg_file, do: "spec/fixtures/artifact.with_broken_tarball.cfg"

          it "fails with error" do
            {result, message} = Parser.parse_file(cfg_file)
            expect(result).to eql(:error)
            expect(message).to have("Tarball file not found: ")
          end
        end
      end

      context "no config file" do
        let :cfg_file, do: "spec/fixtures/no.artifact.cfg.found"

        it "fails with error" do
          {result, message} = Parser.parse_file(cfg_file)
          expect(result).to eql(:error)
          expect(message).to eql("Could not read image config file: #{cfg_file}")
        end
      end
    end
  end
end

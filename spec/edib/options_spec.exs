defmodule EDIBOptionsSpec do
  use ESpec
  alias EDIB.BuildConfig.Artifact
  alias EDIB.Options
  alias EDIB.Utils.{LogWriter, PrefixWriter}

  describe "EDIB.Options" do
    describe "from_cli_arguments/1" do
      context "with empty arguments" do
        let :empty_args, do: []
        let :result_tuple, do: Options.from_cli_arguments(empty_args)
        let :result_ok, do: result_tuple |> elem(0)
        let :options, do: result_tuple |> elem(1)
        subject do: options |> Map.from_struct # structs have no has_key?/2

        it "is ok" do
          expect(result_ok).to eql(:ok)
        end

        it "returns option struct" do
          is_expected.to have_key(:silent)
          is_expected.to have_key(:writer)
          is_expected.to have_key(:artifact_config)
        end
      end

      context "default settings" do
        let :empty_args, do: []
        let :result_tuple, do: Options.from_cli_arguments(empty_args)
        let :options, do: result_tuple |> elem(1)
        subject do: options.silent

        describe ".silent" do
          it do: is_expected.to be_false
        end

        describe ".writer" do
          let :writer, do: &PrefixWriter.write/1
          subject do: options.writer

          it do: is_expected.to eql(writer)
        end

        describe ".artifact_config" do
          subject do: options.artifact_config
          it do: is_expected.to be_struct(Artifact)
        end
      end

      context "with -s/--silent" do
        let :arguments, do: ["-s"] # OptionParser setup should convert this to `--silent`
        let :result_tuple, do: Options.from_cli_arguments(arguments)
        let :options, do: result_tuple |> elem(1)
        subject do: options.silent

        describe ".silent" do
          it do: is_expected.to be_true
        end

        describe ".writer => LogWriter" do
          let :writer, do: &LogWriter.write/1
          subject do: options.writer
          it do: is_expected.to eql(writer)
        end
      end

      context "error cases" do
        describe "on Artifact.from_cli_options/1 failure" do
          let :error_result, do: {:error, "should bubble up"}

          before do
            allow(Artifact).to accept(:from_cli_options, fn(_) -> error_result end)
          end

          it "propagates the error" do
            expect(Options.from_cli_arguments([])).to eql(error_result)
          end
        end
      end
    end
  end
end

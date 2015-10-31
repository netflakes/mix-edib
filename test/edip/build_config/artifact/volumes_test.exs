defmodule EdipBuildConfigArtifactVolumesTest do
  use Pavlov.Case
  import Pavlov.Syntax.Expect

  describe "Edip.BuildConfig.Artifact.Volumes" do
    describe "from_cli_options/1" do
      context "happy path" do
        let :vol1opt,     do: "foo:bar"
        let :vol2opt,     do: "foo:bar:rw"
        let :options,     do: [volume: vol1opt, volume: vol2opt, ignore: :me]

        let :result,      do: Edip.BuildConfig.Artifact.Volumes.from_cli_options(options)
        let :result_ok,   do: elem(result, 0)
        let :result_data, do: elem(result, 1)

        let :volume1,     do: Edip.BuildConfig.Artifact.Volume.from_cli_option(vol1opt) |> elem(1)
        let :volume2,     do: Edip.BuildConfig.Artifact.Volume.from_cli_option(vol2opt) |> elem(1)

        it "is okay" do
          expect result_ok |> to_eq :ok
        end

        it "returns the volumes" do
          expect result_data |> to_include volume1
          expect result_data |> to_include volume2
        end
      end

      context "errors" do
        let :vol_opt,     do: "foo:bar:rw:invalid:setup"
        let :volume,      do: Edip.BuildConfig.Artifact.Volume.from_cli_option(vol_opt)
        let :options,     do: [volume: vol_opt, ignore: :me]

        let :result,      do: Edip.BuildConfig.Artifact.Volumes.from_cli_options(options)
        let :result_error, do: elem(result, 0)
        let :result_data,  do: elem(result, 1)

        it "is an error" do
          expect result_error |> to_eq :error
        end

        it "returns the error message" do
          expect result_data |> to_include "Given volume option is not valid: foo:bar:rw:invalid:setup"
        end
      end
    end

    describe "to_docker_options/1" do
      let :vol1opt, do: "foo:bar"
      let :vol2opt, do: "baz:quux:rw"
      let :volume1, do: Edip.BuildConfig.Artifact.Volume.from_cli_option(vol1opt) |> elem(1)
      let :volume2, do: Edip.BuildConfig.Artifact.Volume.from_cli_option(vol2opt) |> elem(1)
      let :result,  do: Edip.BuildConfig.Artifact.Volumes.to_docker_options([volume1, volume2])

      it "returns a volumes option string for docker run command" do
        expect result |> to_include ~s(-v "#{vol1opt}:ro" -v "#{vol2opt}")
      end
    end
  end
end

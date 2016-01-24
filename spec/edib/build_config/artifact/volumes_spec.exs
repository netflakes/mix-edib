defmodule EDIBBuildConfigArtifactVolumesSpec do
  use ESpec
  alias EDIB.BuildConfig.Artifact.{Volume, Volumes}

  describe "EDIB.BuildConfig.Artifact.Volumes" do
    describe "from_cli_options/1" do
      context "happy path" do
        let :vol1opt, do: "foo:bar"
        let :vol2opt, do: "foo:bar:rw"
        let :options, do: [volume: vol1opt, volume: vol2opt, ignore: :me]

        let :result, do: Volumes.from_cli_options(options)
        let :result_ok, do: elem(result, 0)
        let :result_data, do: elem(result, 1)

        let :volume1, do: vol1opt |> Volume.from_cli_option |> elem(1)
        let :volume2, do: vol2opt |> Volume.from_cli_option |> elem(1)

        it "is okay" do
          expect(result_ok).to eql(:ok)
        end

        it "returns the volumes" do
          expect(result_data).to have(volume1)
          expect(result_data).to have(volume2)
        end
      end

      context "errors" do
        let :vol_opt, do: "foo:bar:rw:invalid:setup"
        let :volume, do: Volume.from_cli_option(vol_opt)
        let :options, do: [volume: vol_opt, ignore: :me]

        let :result, do: Volumes.from_cli_options(options)
        let :result_error, do: elem(result, 0)
        let :result_data, do: elem(result, 1)

        it "is an error" do
          expect(result_error).to eql(:error)
        end

        it "returns the error message" do
          expect(result_data).to have("Given volume option is not valid: #{vol_opt}")
        end
      end
    end

    describe "to_docker_options/1" do
      let :vol1opt, do: "foo:bar"
      let :vol2opt, do: "baz:quux:rw"
      let :volume1, do: vol1opt |> Volume.from_cli_option |> elem(1)
      let :volume2, do: vol2opt |> Volume.from_cli_option |> elem(1)
      let :result, do: [volume1, volume2] |> Volumes.to_docker_options

      it "returns a volumes option string for docker run command" do
        expect(result).to have(~s(-v "#{vol1opt}:ro" -v "#{vol2opt}"))
      end
    end
  end
end

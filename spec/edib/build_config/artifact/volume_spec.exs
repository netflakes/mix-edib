defmodule EDIBBuildConfigArtifactVolumeSpec do
  use ESpec
  alias EDIB.Defaults
  alias EDIB.BuildConfig.Artifact.Volume

  describe "EDIB.BuildConfig.Artifact.Volume" do
    let :readonly, do: "ro"
    let :writeable, do: "rw"

    describe "for_source/1" do
      let :host_path, do: "/host/source/dir"

      it "creates volume for source dir mapping" do
        volume = Volume.for_source(host_path())
        expect(volume.host_path).to eql(host_path())
        expect(volume.container_path()).to eql(Defaults.container_source_dir)
        expect(volume.permissions).to eql(readonly())
      end
    end

    describe "for_tarball/1" do
      let :host_path, do: "/tarball/dir"

      it "creates volume for tarball dir mapping" do
        volume = Volume.for_tarball(host_path())
        expect(volume.host_path).to eql(host_path())
        expect(volume.container_path()).to eql(Defaults.container_tarball_dir)
        expect(volume.permissions).to eql(writeable())
      end
    end

    describe "for_ssh_keys/0" do
      it "creates volume for ssh dir mapping" do
        volume = Volume.for_ssh_keys
        expect(volume.host_path).to eql(Defaults.host_ssh_dir)
        expect(volume.container_path()).to eql(Defaults.container_ssh_dir)
        expect(volume.permissions).to eql(readonly())
      end
    end

    describe "for_hex_packages/0" do
      it "creates volume for hex package dir mapping" do
        volume = Volume.for_hex_packages
        expect(volume.host_path).to eql(Defaults.host_hex_packages_dir)
        expect(volume.container_path()).to eql(Defaults.container_hex_packages_dir)
        expect(volume.permissions).to eql(writeable())
      end
    end

    describe "for_npm_packages/0" do
      it "creates volume for npm package dir mapping" do
        volume = Volume.for_npm_packages
        expect(volume.host_path).to eql(Defaults.host_npm_packages_dir)
        expect(volume.container_path()).to eql(Defaults.container_npm_packages_dir)
        expect(volume.permissions).to eql(writeable())
      end
    end

    describe "from_cli_option/1" do
      let :host_path, do: "/host/dir"
      let :container_path, do: "/container/dir"
      let :valid_permissions, do: readonly()
      let :invalid_permissions, do: "xyz"
      let :invalid_options, do: "rw:xy:zz"

      context "with dirs only (perms = defaults)" do
        let :cli_options, do: "#{host_path()}:#{container_path()}"

        it "creates volume for given mapping" do
          {result, volume} = Volume.from_cli_option(cli_options())
          expect(result).to eql(:ok)
          expect(volume.host_path).to eql(host_path())
          expect(volume.container_path).to eql(container_path())
          expect(volume.permissions).to eql(readonly())
        end
      end

      context "with dirs" do
        context "and permissions" do
          let :cli_options, do: "#{host_path()}:#{container_path()}:#{valid_permissions()}"

          it "creates volume for given mapping" do
            {result, volume} = Volume.from_cli_option(cli_options())
            expect(result).to eql(:ok)
            expect(volume.host_path).to eql(host_path())
            expect(volume.container_path).to eql(container_path())
            expect(volume.permissions).to eql(readonly())
          end
        end

        context "and invalid permissions" do
          let :cli_options, do: "#{host_path()}:#{container_path()}:#{invalid_permissions()}"

          it "fails with error message" do
            {result, volume} = Volume.from_cli_option(cli_options())
            expect(result).to eql(:error)
            expect(volume).to_not be_struct()
            expect(volume).to have("Given volume option is not valid: #{cli_options()}")
          end
        end

        context "and invalid options" do
          let :cli_options, do: "#{host_path()}:#{container_path()}:#{invalid_options()}"

          it "fails with error message" do
            {result, volume} = Volume.from_cli_option(cli_options())
            expect(result).to eql(:error)
            expect(volume).to_not be_struct()
            expect(volume).to have("Given volume option is not valid: #{cli_options()}")
          end
        end
      end

      context "with too few options" do
        let :cli_options, do: "i_feel_alone_without_my_counterpart"

        it "fails with error message" do
          {result, volume} = Volume.from_cli_option(cli_options())
          expect(result).to eql(:error)
          expect(volume).to_not be_struct()
          expect(volume).to have("Given volume option is not valid: #{cli_options()}")
        end
      end
    end

    describe "to_docker_option/1" do
      let :volume, do: Volume.for_ssh_keys
      let :expected_result, do: ~s(-v "#{Defaults.host_ssh_dir}:/root/ssh:ro")

      it "returns a docker volume mapping string" do
        mapping = Volume.to_docker_option(volume())
        expect(mapping).to be_binary()
        expect(mapping).to eql(expected_result())
      end
    end
  end
end

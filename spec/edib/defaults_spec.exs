defmodule EDIBDefaultsSpec do
  use ESpec
  alias EDIB.Defaults

  describe "EDIB.Defaults" do
    let! :version, do: "1.3.2"
    let! :image, do: "edib/edib-tool:#{version}"
    let! :artifact_cfg, do: "artifact.cfg"

    describe "edib_version/0" do
      it "returns the current default version" do
        expect(Defaults.edib_version).to eql(version)
      end
    end

    describe "edib_tool/0" do
      it "returns the current default image" do
        expect(Defaults.edib_tool).to eql(image)
      end
    end

    describe "home_dir/0" do
      it "returns the current home directory" do
        expect(Defaults.home_dir).to eql(System.user_home!)
      end
    end

    describe "current_dir/0" do
      it "returns the current working directory" do
        expect(Defaults.current_dir).to eql(System.cwd!)
      end
    end

    describe "tarball_dir/0" do
      it "returns the current tarballs directory" do
        expect(Defaults.tarball_dir).to eql("#{System.cwd!}/tarballs")
      end
    end

    describe "artifact_config/0" do
      it "returns the current artifact config file name" do
        expect(Defaults.artifact_config).to eql(artifact_cfg)
      end
    end

    describe "artifact_config_path/0" do
      it "returns the current full artifact config file path" do
        expect(Defaults.artifact_config_path).to eql("#{System.cwd!}/tarballs/#{artifact_cfg}")
      end
    end

    describe "docker_cmd/0" do
      it "returns the current docker command" do
        expect(Defaults.docker_cmd).to eql("docker")
      end
    end

    describe "docker_run/0" do
      it "returns the current docker run command" do
        expect(Defaults.docker_run).to eql("docker run")
      end
    end

    describe "docker_import/0" do
      it "returns the current docker import command" do
        expect(Defaults.docker_import).to eql("docker import")
      end
    end

    describe "docker_tag/0" do
      it "returns the current docker tag command" do
        expect(Defaults.docker_tag).to eql("docker tag")
      end
    end

    describe "tarball_command/0" do
      it "returns the current tarball streaming command" do
        expect(Defaults.tarball_command).to eql("gunzip -c")
      end
    end

    describe "docker_run_privileged/0" do
      it "returns the current docker privileged flag default" do
        expect(Defaults.docker_run_privileged).to be_false
      end
    end

    describe "docker_run_no_rm/0" do
      it "returns the current docker no-rm flag default (if --rm should not be used)" do
        expect(Defaults.docker_run_no_rm).to be_false
      end
    end

    describe "permissions/0" do
      it "returns the current docker volume mount permissions" do
        expect(Defaults.permissions).to eql("ro")
      end
    end

    describe "container_source_dir/0" do
      it "returns the current docker container source directory" do
        expect(Defaults.container_source_dir).to eql("/source")
      end
    end

    describe "container_tarball_dir/0" do
      it "returns the current docker container tarballs directory" do
        expect(Defaults.container_tarball_dir).to eql("/stage/tarballs")
      end
    end

    describe "host_ssh_dir/0" do
      it "returns the current host's .ssh directory" do
        expect(Defaults.host_ssh_dir).to eql("#{System.user_home!}/.ssh")
      end
    end

    describe "container_ssh_dir/0" do
      it "returns the current container's (intermediate) ssh directory" do
        expect(Defaults.container_ssh_dir).to eql("/root/ssh")
      end
    end

    describe "host_hex_packages_dir/0" do
      it "returns the current host's hex package cache directory" do
        expect(Defaults.host_hex_packages_dir).to eql("#{System.user_home!}/.hex/packages")
      end
    end

    describe "container_hex_packages_dir/0" do
      it "returns the current container's hex package cache directory" do
        expect(Defaults.container_hex_packages_dir).to eql("/root/.hex/packages")
      end
    end

    describe "host_npm_packages_dir/0" do
      it "returns the current host's npm package cache directory" do
        expect(Defaults.host_npm_packages_dir).to eql("#{System.user_home!}/.npm")
      end
    end

    describe "container_npm_packages_dir/0" do
      it "returns the current container's npm package cache directory" do
        expect(Defaults.container_npm_packages_dir).to eql("/root/.npm")
      end
    end
  end
end

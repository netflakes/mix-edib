defmodule EdipDefaultsTest do
  use Pavlov.Case
  import Pavlov.Syntax.Expect

  describe "Edip.Defaults" do
    describe "edip_version/0" do
      it "returns the current default version" do
        expect Edip.Defaults.edip_version |> to_eq "0.4.3"
      end
    end

    describe "edip_tool/0" do
      it "returns the current default image" do
        expect Edip.Defaults.edip_tool |> to_eq "asaaki/edip-tool:0.4.3"
      end
    end

    describe "home_dir/0" do
      it "returns the current home directory" do
        expect Edip.Defaults.home_dir |> to_eq System.user_home!
      end
    end

    describe "current_dir/0" do
      it "returns the current working directory" do
        expect Edip.Defaults.current_dir |> to_eq System.cwd!
      end
    end

    describe "tarball_dir/0" do
      it "returns the current tarballs directory" do
        expect Edip.Defaults.tarball_dir |> to_eq "#{System.cwd!}/tarballs"
      end
    end

    describe "artifact_config/0" do
      it "returns the current artifact config file name" do
        expect Edip.Defaults.artifact_config |> to_eq "artifact.cfg"
      end
    end

    describe "artifact_config_path/0" do
      it "returns the current full artifact config file path" do
        expect Edip.Defaults.artifact_config_path |> to_eq "#{System.cwd!}/tarballs/artifact.cfg"
      end
    end

    describe "docker_cmd/0" do
      it "returns the current docker command" do
        expect Edip.Defaults.docker_cmd |> to_eq "docker"
      end
    end

    describe "docker_run/0" do
      it "returns the current docker run command" do
        expect Edip.Defaults.docker_run |> to_eq "docker run"
      end
    end

    describe "docker_import/0" do
      it "returns the current docker import command" do
        expect Edip.Defaults.docker_import |> to_eq "docker import"
      end
    end

    describe "docker_tag/0" do
      it "returns the current docker tag command" do
        expect Edip.Defaults.docker_tag |> to_eq "docker tag --force"
      end
    end

    describe "docker_run_privileged/0" do
      it "returns the current docker privileged flag default" do
        expect Edip.Defaults.docker_run_privileged |> to_be_true
      end
    end

    describe "docker_run_no_rm/0" do
      it "returns the current docker no-rm flag default (if --rm should not be used)" do
        expect Edip.Defaults.docker_run_no_rm |> to_eq false
      end
    end

    describe "permissions/0" do
      it "returns the current docker volume mount permissions" do
        expect Edip.Defaults.permissions |> to_eq "ro"
      end
    end

    describe "container_source_dir/0" do
      it "returns the current docker container source directory" do
        expect Edip.Defaults.container_source_dir |> to_eq "/source"
      end
    end

    describe "container_tarball_dir/0" do
      it "returns the current docker container tarballs directory" do
        expect Edip.Defaults.container_tarball_dir |> to_eq "/stage/tarballs"
      end
    end

    describe "host_ssh_dir/0" do
      it "returns the current host's .ssh directory" do
        expect Edip.Defaults.host_ssh_dir |> to_eq "#{System.user_home!}/.ssh"
      end
    end

    describe "container_ssh_dir/0" do
      it "returns the current container's (intermediate) ssh directory" do
        expect Edip.Defaults.container_ssh_dir |> to_eq "/root/ssh"
      end
    end

    describe "host_hex_packages_dir/0" do
      it "returns the current host's hex package cache directory" do
        expect Edip.Defaults.host_hex_packages_dir |> to_eq "#{System.user_home!}/.hex/packages"
      end
    end

    describe "container_hex_packages_dir/0" do
      it "returns the current container's hex package cache directory" do
        expect Edip.Defaults.container_hex_packages_dir |> to_eq "/root/.hex/packages"
      end
    end
  end
end

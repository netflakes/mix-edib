defmodule EDIB.Defaults do
  @moduledoc false

  def edib_version,               do: "1.2"
  def edib_tool,                  do: "edib/edib-tool:#{edib_version}"
  def tarball_dir_name,           do: "tarballs"

  # $HOME should be set, or fallback to a tmp dir:
  def home_dir,                   do: System.user_home || System.tmp_dir
  def current_dir,                do: System.cwd!
  def tarball_dir,                do: current_dir <> "/" <> tarball_dir_name
  def artifact_config,            do: "artifact.cfg"
  def artifact_config_path,       do: tarball_dir <> "/" <> artifact_config

  def docker_cmd,                 do: "docker"
  def docker_run,                 do: "#{docker_cmd} run"
  def docker_import,              do: "#{docker_cmd} import"
  def docker_tag,                 do: "#{docker_cmd} tag --force"

  def docker_run_privileged,      do: false
  def docker_run_no_rm,           do: false

  # read-only, to prevent accidental writes:
  def permissions,                do: "ro"
  # application sources are mounted here:
  def container_source_dir,       do: "/source"
  # read-write mounted tarball dir for artifact:
  def container_tarball_dir,      do: "/stage/tarballs"

  # local host ~/.ssh dir (needed for private repo downloads)
  # Keep in mind: works only for passwordless keys.
  def host_ssh_dir,               do: "#{home_dir}/.ssh"
  def container_ssh_dir,          do: "/root/ssh"

  # Useful for repeated builds without refetch of packages
  # Mount as RW
  def host_hex_packages_dir,      do: "#{home_dir}/.hex/packages"
  def container_hex_packages_dir, do: "/root/.hex/packages"

  # Useful for repeated builds without refetch of npm packages
  # (Phoenix with asset handling)
  # Mount as RW
  def host_npm_packages_dir,      do: "#{home_dir}/.npm"
  def container_npm_packages_dir, do: "/root/.npm"
end

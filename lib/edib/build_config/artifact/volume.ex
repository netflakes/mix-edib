defmodule EDIB.BuildConfig.Artifact.Volume do
  @moduledoc false

  alias EDIB.Defaults

  @valid_permissions   ~w(ro rw)
  @default_permissions "ro"

  defstruct host_path:      nil,
            container_path: nil,
            permissions:    @default_permissions

  def for_source(host_source_dir) do
    new(
      host_source_dir,
      Defaults.container_source_dir,
      @default_permissions
    )
  end

  def for_tarball(host_tarball_dir) do
    new(
      host_tarball_dir,
      Defaults.container_tarball_dir,
      "rw"
    )
  end

  def for_ssh_keys do
    new(
      Defaults.host_ssh_dir,
      Defaults.container_ssh_dir,
      @default_permissions
    )
  end

  def for_npm_packages do
    new(
      Defaults.host_npm_packages_dir,
      Defaults.container_npm_packages_dir,
      "rw"
    )
  end

  def for_hex_packages do
    new(
      Defaults.host_hex_packages_dir,
      Defaults.container_hex_packages_dir,
      "rw"
    )
  end

  def from_cli_option(option) do
    option |> String.split(":") |> maybe_from_cli_option
  end

  defp maybe_from_cli_option([from, to]),
    do: {:ok, new(from, to)}
  defp maybe_from_cli_option([from, to, permissions]),
    do: {:ok, new(from, to, permissions)}
  defp maybe_from_cli_option(option),
    do: {:error, "Given volume option is not valid: #{Enum.join(option, ":")}"}

  def to_docker_option(volume) do
    ~s(-v "#{volume.host_path}:#{volume.container_path}:#{volume.permissions}")
  end

  ### Internals

  defp new(from, to), do: new(from, to, @default_permissions)

  defp new(from, to, permissions) do
    sanitized_permissions = sanitize_permissions(permissions)
    %__MODULE__{
      host_path: from,
      container_path: to,
      permissions: sanitized_permissions
    }
  end

  defp sanitize_permissions(permissions)
    when permissions in @valid_permissions,
    do: permissions
  defp sanitize_permissions(_),
    do: @default_permissions
end

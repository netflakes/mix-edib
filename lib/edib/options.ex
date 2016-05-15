defmodule EDIB.Options do
  @moduledoc false

  alias EDIB.BuildConfig.Artifact

  defstruct silent:          false,
            writer:          &EDIB.Utils.PrefixWriter.write/1,
            artifact_config: %Artifact{}

  @option_aliases [
    h: :hex,
    k: :ssh_keys,
    n: :name,
    p: :prefix,
    s: :silent,
    t: :tag,
    v: :volume,
    x: :strip,
    z: :zip,
  ]

  @option_stricts [
    edib:       :string,
    hex:        :boolean,          # shortcut for ~/.hex/packages directory
    npm:        :boolean,          # shortcut for ~/.npm directory
    name:       :string,
    no_rm:      :boolean,          # `---no-rm`
    prefix:     :string,
    privileged: :boolean,
    silent:     :boolean,
    ssh_keys:   :boolean,          # `--ssh-keys`; shortcut for ~/.ssh directory
    strip:      :boolean,
    tag:        :string,
    test:       :boolean,          # TODO: Not yet implemented!
    volume:     [:string, :keep],
    zip:        :boolean,
  ]

  @option_parser_settings [aliases: @option_aliases, strict: @option_stricts]

  def from_cli_arguments(cli_arguments) do
    cli_arguments
    |> parse_cli_arguments
    |> set_writer
    |> set_artifact_config
    |> consolidate_options
  end

  ### Internals

  defp parse_cli_arguments(cli_arguments) do
    cli_arguments
    |> OptionParser.parse(@option_parser_settings)
    |> elem(0)
  end

  defp set_writer(cli_options) do
    silent = Dict.get(cli_options, :silent, false)
    Dict.merge(cli_options, writer: log_writer(silent))
  end

  defp log_writer(true), do: &EDIB.Utils.LogWriter.write/1
  defp log_writer(_), do: &EDIB.Utils.PrefixWriter.write/1

  defp set_artifact_config(options) do
    options
    |> Artifact.from_cli_options
    |> maybe_set_artifact_config(options)
  end

  defp maybe_set_artifact_config({:ok, config}, options),
    do: {:ok, Dict.merge(options, artifact_config: config)}
  defp maybe_set_artifact_config(error, _),
    do: error

  defp consolidate_options({:ok, options}),
    do: {:ok, struct(__MODULE__, options)}
  defp consolidate_options(error),
    do: error
end

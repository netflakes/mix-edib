defmodule EDIB.BuildConfig.Image do
  @moduledoc false

  defstruct tarball_dir: nil,
            tarball:     nil,
            name:        nil,
            tag:         nil,
            settings:    []   # if not a list (but string),
                              # it is final and will be passed as-is to CLI

  def from_config_file(config_file),
    do: EDIB.BuildConfig.Image.Parser.parse_file(config_file)

  def to_commands(image_config),
    do: EDIB.BuildConfig.Image.Builder.build(image_config)
end

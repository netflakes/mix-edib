use Mix.Config

if Mix.env == :docs do
  config :ex_doc, :markdown_processor, ExDoc.Markdown.Cmark
end

if Mix.env == :lint do
  config :dogma,
    rule_set: Dogma.RuleSet.All,
    exclude: [~r"\A(test|spec)/"],
    override: %{
      LineLength => [max_length: 120]
    }
end

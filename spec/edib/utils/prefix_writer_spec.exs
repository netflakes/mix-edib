defmodule EDIBUtilsPrefixWriterSpec do
  use ESpec
  import ExUnit.CaptureIO
  alias EDIB.Utils.PrefixWriter
  alias IO.ANSI

  describe "EDIB.Utils.PrefixWriter" do
    describe "write/0" do
      context "single line, no carriage return" do
        let :logline, do: "test log line"
        let :prefix,  do: "#{ANSI.magenta}|#{ANSI.reset} "

        it "writes data into the current's directory .edib.log file" do
          content = capture_io(fn -> PrefixWriter.write(logline) end)
          expect(content).to have(prefix <> logline)
        end
      end

      context "single line, with carriage return" do
        let :logline, do: "test log line\n"
        let :prefix,  do: "#{ANSI.magenta}|#{ANSI.reset} "

        it "writes data into the current's directory .edib.log file" do
          content = capture_io(fn -> PrefixWriter.write(logline) end)
          expect(content).to have(prefix <> logline)
        end
      end

      context "multiple lines in a single message" do
        let :logline, do: "test log line\nsecond line"
        let :prefix,  do: "#{ANSI.magenta}|#{ANSI.reset} "

        it "writes data into the current's directory .edib.log file" do
          # Hint
          # INPUT:
          #   foo
          #   bar
          # OUTPUT:
          #   | foo
          #   | bar
          content = capture_io(fn -> PrefixWriter.write(logline) end)
          expected_content =
            logline
            |> String.split("\n")
            |> Enum.map(&("#{prefix}#{&1}"))
            |> Enum.join("\n")
          expect(content).to have(expected_content)
        end
      end
    end
  end
end

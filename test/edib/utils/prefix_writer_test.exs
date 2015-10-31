defmodule EDIBUtilsPrefixWriterTest do
  use Pavlov.Case
  import Pavlov.Syntax.Expect
  import ExUnit.CaptureIO

  describe "EDIB.Utils.PrefixWriter" do
    describe "write/0" do
      context "single line, no carriage return" do
        let :logline, do: "test log line"
        let :prefix,  do: "#{IO.ANSI.magenta}|#{IO.ANSI.reset} "

        it "writes data into the current's directory .edib.log file" do
          content = capture_io(fn -> EDIB.Utils.PrefixWriter.write(logline) end)
          expect content |> to_include "#{prefix}#{logline}"
        end
      end

      context "single line, with carriage return" do
        let :logline, do: "test log line\n"
        let :prefix,  do: "#{IO.ANSI.magenta}|#{IO.ANSI.reset} "

        it "writes data into the current's directory .edib.log file" do
          content = capture_io(fn -> EDIB.Utils.PrefixWriter.write(logline) end)
          expect content |> to_include "#{prefix}#{logline}"
        end
      end

      context "multiple lines in a single message" do
        let :logline, do: "test log line\nsecond line"
        let :prefix,  do: "#{IO.ANSI.magenta}|#{IO.ANSI.reset} "

        it "writes data into the current's directory .edib.log file" do
          # Hint
          # data:
          #   foo
          #   bar
          # result:
          #   | foo
          #   | bar
          content = capture_io(fn -> EDIB.Utils.PrefixWriter.write(logline) end)
          expected_content = logline |> String.split("\n") |> Enum.map(&("#{prefix}#{&1}")) |> Enum.join("\n")
          expect content |> to_include expected_content
        end
      end
    end
  end
end

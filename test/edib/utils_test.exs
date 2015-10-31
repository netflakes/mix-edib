defmodule EDIBUtilsTest do
  use Pavlov.Case
  import Pavlov.Syntax.Expect
  import ExUnit.CaptureIO

  describe "EDIB.Utils" do
    describe "print/1" do
      let :message, do: "test message"

      it "prints a message to the shell output" do
        result = capture_io(fn -> EDIB.Utils.print(message) end)
        expect result |> to_include(message)
      end
    end

    describe "debug/1" do
      let :message, do: "debug test message"

      it "prints a debug message" do
        result = capture_io(fn -> EDIB.Utils.debug(message) end)
        expect result |> to_include("==>")
        expect result |> to_include(message)
      end
    end

    describe "info/1" do
      let :message, do: "info test message"

      it "prints a info message" do
        result = capture_io(fn -> EDIB.Utils.info(message) end)
        expect result |> to_include("==>")
        expect result |> to_include(message)
      end
    end

    describe "warn/1" do
      let :message, do: "warn test message"

      it "prints a warn message" do
        result = capture_io(fn -> EDIB.Utils.warn(message) end)
        expect result |> to_include("==>")
        expect result |> to_include(message)
      end
    end

    describe "notice/1" do
      let :message, do: "notice test message"

      it "prints a notice message" do
        result = capture_io(fn -> EDIB.Utils.notice(message) end)
        expect result |> not_to_include("==>")
        expect result |> to_include(message)
      end
    end

    describe "error/1" do
      let :message, do: "error test message"

      it "prints a error message" do
        result = capture_io(fn -> EDIB.Utils.error(message) end)
        expect result |> to_include("==>")
        expect result |> to_include(message)
      end
    end

    describe "abort!/0" do
      it "exits the running process" do
        expect fn -> EDIB.Utils.abort! end |> to_have_exited
      end
    end

    describe "do_cmd/2" do
      let :callback, do: fn(out) -> out end

      it "triggers a command" do
        result = EDIB.Utils.do_cmd("echo hello", callback)
        expect result |> to_eq(0)
      end
    end

    describe "print_info/1" do
      context "on okay" do
        let :data,    do: {:ok, "my data"}
        let :message, do: "yep, ok"

        it "prints the message if ok and returns the data" do
          printer_fn = fn ->
            expect EDIB.Utils.print_info(data, message) |> to_eq(data)
          end
          expect capture_io(printer_fn) |> to_include(message)
        end
      end

      context "on error" do
        let :error_data, do: {:error, "my error"}
        let :message,    do: "nope, no ok"

        it "does not print any message, but returns the error data" do
          result = EDIB.Utils.print_info(error_data, message)
          expect result |> not_to_include(message)
          expect result |> to_eq(error_data)
        end
      end
    end

    describe "print_notice/1" do
      context "on okay" do
        let :data,    do: {:ok, "my data"}
        let :message, do: "yep, ok"

        it "prints the message if ok and returns the data" do
          printer_fn = fn ->
            expect EDIB.Utils.print_notice(data, message) |> to_eq(data)
          end
          expect capture_io(printer_fn) |> to_include(message)
        end
      end

      context "on error" do
        let :error_data, do: {:error, "my error"}
        let :message,    do: "nope, no ok"

        it "does not print any message, but returns the error data" do
          result = EDIB.Utils.print_notice(error_data, message)
          expect result |> not_to_include(message)
          expect result |> to_eq(error_data)
        end
      end
    end
  end
end

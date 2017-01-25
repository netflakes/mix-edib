defmodule EdibUtilsSpec do
  use ESpec
  import ExUnit.CaptureIO
  alias EDIB.Utils

  describe "EDIB.Utils" do
    context "printing" do
      let! :prefix, do: "==>"
      let! :message, do: "a logged test message"

      describe "print/1" do
        it "prints a message to the shell output" do
          result = capture_io(fn -> Utils.print(message()) end)
          expect(result).to_not have(prefix())
          expect(result).to have(message())
        end
      end

      describe "debug/1" do
        it "prints debug message" do
          result = capture_io(fn -> Utils.debug(message()) end)
          expect(result).to have(prefix())
          expect(result).to have(message())
        end
      end

      describe "info/1" do
        it "prints info message" do
          result = capture_io(fn -> Utils.info(message()) end)
          expect(result).to have(prefix())
          expect(result).to have(message())
        end
      end

      describe "warn/1" do
        it "prints warn message" do
          result = capture_io(fn -> Utils.warn(message()) end)
          expect(result).to have(prefix())
          expect(result).to have(message())
        end
      end

      describe "error/1" do
        it "prints error message" do
          result = capture_io(fn -> Utils.error(message()) end)
          expect(result).to have(prefix())
          expect(result).to have(message())
        end
      end

      describe "notice/1" do
        it "prints notice message" do
          result = capture_io(fn -> Utils.notice(message()) end)
          expect(result).to_not have(prefix())
          expect(result).to have(message())
        end
      end
    end

    describe "abort!/0" do
      let :abort_fun,
        do: fn -> Utils.abort! end

      let :result do
        try do
          abort_fun().()
        catch
          :exit, _ -> true
          _ -> false
        end
      end

      it "exits the running process" do
        expect(result()).to be_true()
      end
    end

    describe "do_cmd/2" do
      let :callback, do: fn(out) -> out end

      it "triggers a command" do
        result = Utils.do_cmd("echo hello", callback())
        expect(result).to eql(0)
      end
    end

    describe "conditional printers" do
      let :ok_data, do: {:ok, "my ok data"}
      let :ok_message, do: "yep, ok"
      let :error_data, do: {:error, "my error data"}
      let :error_message, do: "nope, not ok"

      describe "print_info/1" do
        context "if :ok" do
          let :printer_fn, do: fn ->
            expect(Utils.print_info(ok_data(), ok_message())) |> to(eq ok_data())
          end

          it "prints the message if ok and returns the data" do
            result = capture_io(printer_fn())
            expect(result).to have(ok_message())
          end
        end

        context "if :error" do
          it "does not print any message, but returns the error data" do
            result = Utils.print_info(error_data(), error_message())
            expect(result).to be_tuple()
            expect(result).to eql(error_data())
          end
        end
      end

      describe "print_notice/1" do
        context "if :ok" do
          let :printer_fn, do: fn ->
            expect(Utils.print_notice(ok_data(), ok_message())) |> to(eq ok_data())
          end

          it "prints the message if ok and returns the data" do
            result = capture_io(printer_fn())
            expect(result).to have(ok_message())
          end
        end

        context "if :error" do
          it "does not print any message, but returns the error data" do
            result = Utils.print_notice(error_data(), error_message())
            expect(result).to be_tuple()
            expect(result).to eql(error_data())
          end
        end
      end
    end
  end
end

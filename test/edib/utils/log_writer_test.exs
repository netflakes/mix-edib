defmodule EDIBUtilsLogWriterTest do
  use Pavlov.Case
  import Pavlov.Syntax.Expect

  describe "EDIB.Utils.LogWriter" do
    describe "write/0" do
      let :logfile, do: EDIB.Utils.LogWriter.log_file
      let :logline, do: "test log line"

      before :each do
        File.rm_rf(logfile)
        :ok
      end

      it "writes data into the current's directory .edib.log file" do
        EDIB.Utils.LogWriter.write(logline)
        content = File.read!(logfile)
        expect content |> to_include logline
      end
    end
  end
end

defmodule EDIBUtilsLogWriterSpec do
  use ESpec
  alias EDIB.Utils.LogWriter

  describe "EDIB.Utils.LogWriter" do
    describe "write/0" do
      let :logfile, do: LogWriter.log_file
      let :logline, do: "test log line"

      before do
        File.rm_rf(logfile)
      end

      it "writes data into the current's directory .edib.log file" do
        LogWriter.write(logline)
        content = File.read!(logfile)
        expect(content).to have(logline)
      end
    end
  end
end

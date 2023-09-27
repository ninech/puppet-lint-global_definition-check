require "spec_helper"

describe "global_function" do
  context "just a function" do
    let(:code) do
      <<-EOS
      class test {
        ensure_packages(['wordpress']);
      }
      EOS
    end

    it "should not detect any problems" do
      expect(problems).to have(0).problems
    end
  end

  context "global functions" do
    let(:code) do
      <<-EOS
      class test {
        ensure_packages(['wordpress']);
      }

      ensure_packages(['wordpress']);
      EOS
    end

    it "should detect a problem" do
      expect(problems).to have(1).problems
    end
  end
end

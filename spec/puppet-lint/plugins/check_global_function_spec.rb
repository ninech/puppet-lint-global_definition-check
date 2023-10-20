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
      expect(problems.size).to eq(0)
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
      expect(problems.size).to eq(1)
    end
  end

  context "custom function definition with function call" do
    let(:code) do
      <<-EOS
      function test_module::test_function() >> Any {
        function_call()
      }
      EOS
    end

    it "should not detect any problems" do
      expect(problems.size).to eq(0)
    end
  end
end

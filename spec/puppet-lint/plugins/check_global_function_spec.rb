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

  context "module function definition" do
    let(:code) do
      <<-EOS
      # @summary function to clean hash of undef and empty values
      function nine_networkinterfaces::delete_empty_values(
        Hash $hash,
      ) >> Hash {
        $hash.filter |$key, $value| {
          case $value {
            Collection: { $value =~ NotUndef and !$value.empty }
            default:    { $value =~ NotUndef }
          }
        }
      }
      EOS
    end

    it "should not detect any problems" do
      expect(problems.size).to eq(0)
    end
  end
end

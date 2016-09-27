# frozen_string_literal: true
require "spec_helper"

describe Sanscript::Benchmark do
  let!(:orig_stdout) { $stdout }
  before do
    $stdout = StringIO.new
  end

  after do |example|
    if example.exception
      message = $stdout.string
      orig_stdout.puts message
    end
    $stdout = orig_stdout
  end

  it { is_expected.to respond_to(:detect!) }
  it "benchmarks detection" do
    expect(described_class.detect!(0.1, 0)).to be_truthy
  end

  it { is_expected.to respond_to(:transliterate_roman!) }
  it "benchmarks roman-source transliteration" do
    expect(described_class.transliterate_roman!(0.1, 0)).to be_truthy
  end

  it { is_expected.to respond_to(:transliterate_brahmic!) }
  it "benchmarks brahmic-source transliteration" do
    expect(described_class.transliterate_brahmic!(0.1, 0)).to be_truthy
  end
end

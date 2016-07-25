# frozen_string_literal: true
require "spec_helper"

describe Sanscript do
  it "has a version number" do
    expect(Sanscript::VERSION).not_to be nil
  end

  context ".detect" do
    it "returns the same result as Detect.detect_scheme" do
      expect(described_class.detect(scheme_data[:devanagari][:sentence]))
        .to eq(described_class::Detect.detect_scheme(scheme_data[:devanagari][:sentence]))
    end
  end

  context ".transliterate" do
    it "returns a result with source and destination scheme specified" do
      expect(described_class.transliterate(scheme_data[:devanagari][:sentence], :devanagari, :iast))
        .to eq(scheme_data[:iast][:sentence])
    end
    it "returns a result with just destination scheme specified" do
      expect(described_class.transliterate(scheme_data[:devanagari][:sentence], :iast))
        .to eq(scheme_data[:iast][:sentence])
    end
  end
end

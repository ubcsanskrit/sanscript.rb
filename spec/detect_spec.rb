# frozen_string_literal: true
require "spec_helper"

describe Sanscript::Detect do
  scheme_names = %i[bengali devanagari gujarati gurmukhi kannada malayalam
                    oriya telugu iast hk slp1 itrans velthuis]

  context ".detect_scheme" do
    scheme_names.each do |name|
      it "detects #{name} from sample marks" do
        expect(described_class.detect_scheme(@scheme_data[name][:marks])).to eq(name)
      end
      it "detects #{name} from sample sentence" do
        expect(described_class.detect_scheme(@scheme_data[name][:sentence])).to eq(name)
      end
    end
    it "prioritizes ITRANS over Velthuis when ambiguous" do
      expect(described_class.detect_scheme("aa")).to eq(:itrans)
    end
    it "differentiates Kolkata from IAST" do
      expect(described_class.detect_scheme("bhō rājan")).to eq(:kolkata)
    end

    it "has test for tamil"
  end
end

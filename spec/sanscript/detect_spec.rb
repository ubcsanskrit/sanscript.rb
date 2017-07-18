# frozen_string_literal: true

require "spec_helper"

describe Sanscript::Detect do
  scheme_names = %i[bengali devanagari gujarati gurmukhi kannada malayalam
                    oriya telugu iast hk slp1 itrans velthuis]

  it { expect(described_class).to respond_to :detect_scheme }

  context ".ruby_detect_scheme" do
    scheme_names.each do |name|
      it "detects #{name} from sample marks" do
        expect(described_class.ruby_detect_scheme(scheme_data[name][:marks])).to eq(name)
      end
      it "detects #{name} from sample sentence" do
        expect(described_class.ruby_detect_scheme(scheme_data[name][:sentence])).to eq(name)
      end
    end
    it "detects tamil from short marks" do
      expect(described_class.ruby_detect_scheme(scheme_data[:tamil][:short_marks])).to eq(:tamil)
    end
    it "detects tamil from short vowels" do
      expect(described_class.ruby_detect_scheme(scheme_data[:tamil][:short_vowels])).to eq(:tamil)
    end
    it "prioritizes ITRANS over Velthuis when ambiguous" do
      expect(described_class.ruby_detect_scheme("aa")).to eq(:itrans)
    end
    it "differentiates Kolkata from IAST" do
      expect(described_class.ruby_detect_scheme("bhō rājan")).to eq(:kolkata)
    end
  end

  if Sanscript::RUST_AVAILABLE
    context ".rust_detect_scheme" do
      scheme_names.each do |name|
        it "detects #{name} from sample marks" do
          expect(described_class.rust_detect_scheme(scheme_data[name][:marks])).to eq(name)
        end
        it "detects #{name} from sample sentence" do
          expect(described_class.rust_detect_scheme(scheme_data[name][:sentence])).to eq(name)
        end
      end
      it "detects tamil from short marks" do
        expect(described_class.rust_detect_scheme(scheme_data[:tamil][:short_marks])).to eq(:tamil)
      end
      it "detects tamil from short vowels" do
        expect(described_class.rust_detect_scheme(scheme_data[:tamil][:short_vowels])).to eq(:tamil)
      end
      it "prioritizes ITRANS over Velthuis when ambiguous" do
        expect(described_class.rust_detect_scheme("aa")).to eq(:itrans)
      end
      it "differentiates Kolkata from IAST" do
        expect(described_class.rust_detect_scheme("bhō rājan")).to eq(:kolkata)
      end
    end
  end
end

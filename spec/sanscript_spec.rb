# frozen_string_literal: true
require "spec_helper"

describe Sanscript do
  it "has a version number" do
    expect(Sanscript::VERSION).not_to be nil
  end

  describe ".roman_scheme?" do
    roman = %i[iast itrans hk kolkata slp1 velthuis wx]
    other = %i[bengali devanagari gujarati gurmukhi kannada malayalam oriya tamil telugu]

    roman.each do |scheme|
      it ":#{scheme} should be a member" do
        expect(described_class.roman_scheme?(scheme)).to eq(true)
      end
    end

    other.each do |scheme|
      it ":#{scheme} should not be a member" do
        expect(described_class.roman_scheme?(scheme)).to eq(false)
      end
    end
  end
end

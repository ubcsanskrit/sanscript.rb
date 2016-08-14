# frozen_string_literal: true

module Sanscript
  module Detect
    # Module implementing `detect_scheme` method using Ruby 2.x-compatible syntax.
    module Ruby2x
      # Attempts to detect the encoding scheme of the provided string.
      #
      # @param text [String] a string of Sanskrit text
      # @return [Symbol, nil] the Symbol of the scheme, or nil if no match
      def ruby_detect_scheme(text)
        text = text.to_str.gsub(RE_CONTROL_BLOCK, "")

        # rubocop:disable Style/CaseEquality

        # Brahmic schemes are all within a specific range of code points.
        if RE_BRAHMIC_RANGE === text
          RE_BRAHMIC_SCRIPTS.each do |script, regex|
            return script if regex === text
          end
        end

        # Romanizations
        if RE_IAST_OR_KOLKATA_ONLY === text
          return :kolkata if RE_KOLKATA_ONLY === text
          :iast
        elsif RE_ITRANS_ONLY === text
          :itrans
        elsif RE_SLP1_ONLY === text
          :slp1
        elsif RE_VELTHUIS_ONLY === text
          :velthuis
        elsif RE_ITRANS_OR_VELTHUIS_ONLY === text
          :itrans
        elsif RE_HARVARD_KYOTO === text
          :hk
        end
      end
    end
  end
end

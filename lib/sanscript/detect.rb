# frozen_string_literal: true
# rubocop:disable Style/CaseEquality

#
# Developed from code available @ https://github.com/sanskrit/detect.js
#
module Sanscript
  module Detect
    # Match any character in the block of Brahmic scripts
    # between Devanagari and Malayalam.
    RE_BRAHMIC_RANGE = /[\u0900-\u0d7f]/

    # Match each individual Brahmic script.
    RE_BRAHMIC_SCRIPTS = {
      devanagari: /\p{Devanagari}/,
      bengali: /\p{Bengali}/,
      gurmukhi: /\p{Gurmukhi}/,
      gujarati: /\p{Gujarati}/,
      oriya: /\p{Oriya}/,
      tamil: /\p{Tamil}/,
      telugu: /\p{Telugu}/,
      kannada: /\p{Kannada}/,
      malayalam: /\p{Malayalam}/,
    }.freeze

    # Match on special Roman characters
    RE_IAST_OR_KOLKATA_ONLY = /[āīūṛṝḷḹēōṃḥṅñṭḍṇśṣḻ]/i

    # Match on Kolkata-specific Roman characters
    RE_KOLKATA_ONLY = /[ēō]/i

    # Match on ITRANS-only
    RE_ITRANS_ONLY = /ee|oo|\^[iI]|RR[iI]|L[iI]|~N|N\^|Ch|chh|JN|sh|Sh|\.a/

    # Match on SLP1-only characters and bigrams
    RE_SLP1_ONLY = /[fFxXEOCYwWqQPB]|kz|N[kg]|tT|dD|S[cn]|[aAiIuUeo]R|G[yr]/

    # Match on Velthuis-only characters
    RE_VELTHUIS_ONLY = /\.[mhnrlntds]|"n|~s/

    # Match on chars shared by ITRANS and Velthuis
    RE_ITRANS_OR_VELTHUIS_ONLY = /aa|ii|uu|~n/

    # Match on characters available in Harvard-Kyoto
    RE_HARVARD_KYOTO = /[aAiIuUeoRMHkgGcjJTDNtdnpbmyrlvzSsh]/

    # Match ##...## or {#...#} control blocks.
    RE_CONTROL_BLOCK = /(?<!\\)##.*?(?<!\\)##|(?<!\\)\{#.*?(?<!\\)#\}/

    private_constant :RE_BRAHMIC_RANGE, :RE_BRAHMIC_SCRIPTS, :RE_IAST_OR_KOLKATA_ONLY,
                     :RE_KOLKATA_ONLY, :RE_ITRANS_ONLY, :RE_SLP1_ONLY, :RE_VELTHUIS_ONLY,
                     :RE_ITRANS_OR_VELTHUIS_ONLY, :RE_HARVARD_KYOTO, :RE_CONTROL_BLOCK

    module_function

    # Attempts to detect the encoding scheme of the provided string.
    #
    # @param text [String] a string of Sanskrit text
    # @return [Symbol, nil] the Symbol of the scheme, or nil if no match
    def detect_scheme(text)
      text = text.to_str.gsub(RE_CONTROL_BLOCK, "")

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

    # If Ruby 2.4's Regexp#match? method is found, use this version of detect_scheme
    if Regexp.method_defined?(:match?)
      # @!visibility private
      def detect_scheme(text)
        text = text.to_str.gsub(RE_CONTROL_BLOCK, "")

        # Brahmic schemes are all within a specific range of code points.
        if RE_BRAHMIC_RANGE.match?(text)
          RE_BRAHMIC_SCRIPTS.each do |script, regex|
            return script if regex.match?(text)
          end
        end

        # Romanizations
        if RE_IAST_OR_KOLKATA_ONLY.match?(text)
          return :kolkata if RE_KOLKATA_ONLY.match?(text)
          :iast
        elsif RE_ITRANS_ONLY.match?(text)
          :itrans
        elsif RE_SLP1_ONLY.match?(text)
          :slp1
        elsif RE_VELTHUIS_ONLY.match?(text)
          :velthuis
        elsif RE_ITRANS_OR_VELTHUIS_ONLY.match?(text)
          :itrans
        elsif RE_HARVARD_KYOTO.match?(text)
          :hk
        else
          :unknown
        end
      end
    end
  end
end

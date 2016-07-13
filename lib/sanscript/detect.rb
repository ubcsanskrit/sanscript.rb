# frozen_string_literal: true
#
# Developed from code available @ https://github.com/sanskrit/detect.js
#
module Sanscript
  module Detect
    # Match any character in the block of Brahmic scripts
    # between Devanagari and Malayalam.
    RE_BRAHMIC_RANGE = /[\u0090-\u0d7f]/

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
    RE_SLP1_ONLY = /[fFxXEOCYwWqQPB]|kz|Nk|Ng|tT|dD|Sc|Sn|[aAiIuUfFxXeEoO]R|G[yr]|(\\W|^)G'/

    # Match on Velthuis-only characters
    RE_VELTHUIS_ONLY = /\.[mhnrlntds]|"n|~s/

    # Match on chars shared by ITRANS and Velthuis
    RE_ITRANS_OR_VELTHUIS_ONLY = /aa|ii|uu|~n/

    # Match on characters unavailable in Harvard-Kyoto
    RE_HARVARD_KYOTO = /[aAiIuUeoRMHkgGcjJTDNtdnpbmyrlvzSsh]/

    private_constant :RE_BRAHMIC_RANGE, :RE_BRAHMIC_SCRIPTS, :RE_IAST_OR_KOLKATA_ONLY,
                     :RE_KOLKATA_ONLY, :RE_ITRANS_ONLY, :RE_SLP1_ONLY, :RE_VELTHUIS_ONLY,
                     :RE_ITRANS_OR_VELTHUIS_ONLY, :RE_HARVARD_KYOTO

    module_function

    def detect_script(text)
      # Brahmic schemes are all within a specific range of code points.
      if text =~ RE_BRAHMIC_RANGE
        RE_BRAHMIC_SCRIPTS.each do |script, regex|
          return script if text =~ regex
        end
      end

      # Romanizations
      if text =~ RE_IAST_OR_KOLKATA_ONLY
        text =~ RE_KOLKATA_ONLY ? :kolkata : :iast
      elsif text =~ RE_ITRANS_ONLY
        :itrans
      elsif text =~ RE_SLP1_ONLY
        :slp1
      elsif text =~ RE_VELTHUIS_ONLY
        :velthuis
      elsif text =~ RE_ITRANS_OR_VELTHUIS_ONLY
        :itrans
      elsif text =~ RE_HARVARD_KYOTO
        :hk
      else
        :unknown
      end
    end
  end
end

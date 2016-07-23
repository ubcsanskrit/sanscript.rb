# frozen_string_literal: true
require "ragabash"

require "sanscript/version"
require "sanscript/detect"
require "sanscript/transliterate"
require "sanscript/benchmark"

# Sanscript.rb detection/transliteration module for Sanskrit.
module Sanscript
  module_function

  # Attempts to detect the encoding scheme of the provided string.
  # Simple proxy for {Detect.detect_scheme}
  #
  # @param text [String] a string of Sanskrit text
  # @return [Symbol, nil] the Symbol of the scheme, or nil if no match
  def detect(text)
    Detect.detect_scheme(text)
  end

  # Transliterates a string, optionally detecting its source-scheme first.
  #
  # @overload transliterate(text, from, to, **opts)
  #   @param text [String] the String to transliterate
  #   @param from [Symbol] the name of the scheme to transliterate from
  #   @param to [Symbol] the name of the scheme to transliterate to
  #   @option opts [Boolean] :skip_sgml (false) escape SGML-style tags in text string
  #   @option opts [Boolean] :syncope (false) activate Hindi-style schwa syncope
  #   @return [String] the transliterated String
  #
  # @overload transliterate(text, to, **opts)
  #   @param text [String] the String to transliterate
  #   @param to [Symbol] the name of the scheme to transliterate to
  #   @option opts [Symbol] :default_scheme a default scheme to fall-back to if detection fails
  #   @option opts [Boolean] :skip_sgml (false) escape SGML-style tags in text string
  #   @option opts [Boolean] :syncope (false) activate Hindi-style schwa syncope
  #   @return [String, nil] the transliterated String, or nil if detection and fallback fail
  def transliterate(text, from, to = nil, **opts)
    if to.nil?
      to = from
      from = Detect.detect_scheme(text) || opts[:default_scheme] || return
    end
    Transliterate.transliterate(text, from, to, opts)
  end
end

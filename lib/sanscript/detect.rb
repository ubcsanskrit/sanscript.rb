# frozen_string_literal: true

require "sanscript/detect/constants"

module Sanscript
  # Transliteration scheme detection module.
  # Developed from code available @ https://github.com/sanskrit/detect.js
  module Detect
    if Regexp.method_defined?(:match?)
      # :nocov:
      require "sanscript/detect/ruby24"
      extend Ruby24
    else
      require "sanscript/detect/ruby2x"
      extend Ruby2x
      # :nocov:
    end

    # @!method detect_scheme(text)
    # Attempts to detect the encoding scheme of the provided string.
    #
    # Uses the most efficient implementation for your ruby version
    # (either {Ruby2x#ruby_detect_scheme} or {Ruby24#ruby_detect_scheme})
    # at first, which may be then overriden by the Rust native extension
    # (see {Sanscript.rust_enable!} and {Sanscript.rust_disable!})
    #
    # @param text [String] a string of Sanskrit text
    # @return [Symbol, nil] the Symbol of the scheme, or nil if no match
    # @!scope module
    # @!visibility public
    singleton_class.send(:alias_method, :detect_scheme, :ruby_detect_scheme)
  end
end

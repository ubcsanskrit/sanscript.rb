# frozen_string_literal: true

module Sanscript
  module Detect
    # Module stub for implementing `detect_scheme` method using Rust native extension.
    # (Note: This module will only exist if the native extension is available and {Sanscript.rust_load!} has been run.)
    module Rust
      # @!method rust_detect_scheme(text)
      # Attempts to detect the encoding scheme of the provided string.
      # Uses Rust native extension for vastly increased performance.
      #
      # @param text [String] a string of Sanskrit text
      # @return [Symbol, nil] the Symbol of the scheme, or nil if no match
    end
  end
end

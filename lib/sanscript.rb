# frozen_string_literal: true
require "sanscript/version"
require "sanscript/detect"
require "sanscript/transliterate"

module Sanscript
  module_function

  # Proxies the Detect.detect_script method
  #
  def detect(text)
    Detect.detect_script(text)
  end

  # The transliterate method accepts multiple signatures
  #   .transliterate(text, to) will auto-detect the source script
  #   .transliterate(text, to, from) will specify the source and target script
  #
  #   Final Hash arguments are passed along as options.
  #
  def transliterate(text, first, second = nil, **options)
    if second.nil?
      second = first
      first = Detect.detect_script(data)
    end
    Transliterate.transliterate(text, first, second, options)
  end
end

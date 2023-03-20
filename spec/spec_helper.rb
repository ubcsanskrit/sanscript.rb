# frozen_string_literal: true

require "simplecov"
SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
]
SimpleCov.start

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "sanscript"

require "support/scheme_data"
require "support/letter_tests"
require "support/text_tests"

RSpec.configure do |config|
  config.include_context "scheme_data"
end
RSpec::Matchers.define_negated_matcher :not_be_empty, :be_empty

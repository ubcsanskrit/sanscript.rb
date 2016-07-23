# frozen_string_literal: true
require "codeclimate-test-reporter"
SimpleCov.start do
  add_filter "vendor"
  add_filter "spec"
  formatter SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      CodeClimate::TestReporter::Formatter,
    ]
  )
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "sanscript"

require "support/scheme_data"
require "support/letter_tests"
require "support/text_tests"

RSpec.configure do |config|
  config.include_context "scheme_data"
end
RSpec::Matchers.define_negated_matcher :not_be_empty, :be_empty

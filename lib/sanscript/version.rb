# frozen_string_literal: true

module Sanscript
  # The version number
  VERSION = "0.9.1".freeze

  GEM_ROOT = Pathname.new(File.realpath(File.join(__dir__, "..", "..")))
  private_constant :GEM_ROOT
end

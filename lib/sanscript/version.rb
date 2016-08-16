# frozen_string_literal: true
module Sanscript
  # The version number
  VERSION = "0.6.2"

  GEM_ROOT = Pathname.new(File.realpath(File.join(__dir__, "..", "..")))
  private_constant :GEM_ROOT
end

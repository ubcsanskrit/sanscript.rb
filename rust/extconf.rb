# frozen_string_literal: true
require "mkmf"
unless !system("cargo --version") || !system("rustc --version")
  create_makefile("sanscript")
  File.write("Makefile", "all:\n\tcargo build --release\n\nclean:\n\trm -rf target\n\ninstall: ;\n")
end

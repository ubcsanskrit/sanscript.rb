# frozen_string_literal: true
require "mkmf"
if !system("cargo --version") || !system("rustc --version")
  File.unlink("Makefile")
else
  create_makefile("sanscript")
  File.write("Makefile", "all:\n\tcargo build --release\n\nclean:\n\trm -rf target\n\trm libsanscript.*\n\ninstall:\n\tmv target/release/libsanscript.* .\n\trm -rf target\n")
end

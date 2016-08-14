# frozen_string_literal: true
if !system("cargo --version") || !system("rustc --version")
  create_makefile("sanscript")
else
  create_makefile("sanscript")
  File.write("Makefile", "all:\n  cargo build --release\nclean:\n  rm -rf target\ninstall: ;")
end

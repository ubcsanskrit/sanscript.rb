#[macro_use] extern crate lazy_static;
extern crate ruby_sys;
extern crate regex;

mod rb;
// Exports a Sanscript::Detect::Rust module
pub mod detect;

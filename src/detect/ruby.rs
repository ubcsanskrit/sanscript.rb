use detect;

use rb;
use rb::{CallbackPtr, Value};

// Initialize all of the Ruby-specific static variables.
lazy_static! {
  // Lookup table for Ruby Results
  static ref RUBY_RESULTS: [Value; 16] = [
    rb::RB_NIL,                    // 0
    rb::str_to_sym("devanagari"),  // 1
    rb::str_to_sym("bengali") ,    // 2
    rb::str_to_sym("gurmukhi"),    // 3
    rb::str_to_sym("gujarati"),    // 4
    rb::str_to_sym("oriya"),       // 5
    rb::str_to_sym("tamil"),       // 6
    rb::str_to_sym("telugu"),      // 7
    rb::str_to_sym("kannada"),     // 8
    rb::str_to_sym("malayalam"),   // 9
    rb::str_to_sym("iast"),        // 10
    rb::str_to_sym("kolkata"),     // 11
    rb::str_to_sym("itrans"),      // 12
    rb::str_to_sym("slp1"),        // 13
    rb::str_to_sym("velthuis"),    // 14
    rb::str_to_sym("hk")           // 15
  ];
}

fn rbstr_detect_scheme(_rself: Value, s: Value) -> Value {
  let r_str = rb::rbstr_to_str(&s);
  let result = detect::detect_scheme(r_str);
  return RUBY_RESULTS[result];
}

#[no_mangle]
pub extern fn init_rusty_sanscript() {
  let m_sanscript = rb::define_module("Sanscript");
  let m_detect = rb::define_module_under(&m_sanscript, "Detect");
  let m_rust = rb::define_module_under(&m_sanscript, "Rust");
  let m_rust_detect = rb::define_module_under(&m_rust, "Detect");
  rb::define_method(&m_rust_detect, "rust_detect_scheme",
    rbstr_detect_scheme as CallbackPtr, 1);
  rb::extend_object(&m_detect, &m_rust_detect);
}

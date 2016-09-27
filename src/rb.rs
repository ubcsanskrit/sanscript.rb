use std::ffi::{CStr, CString};

use ruby_sys::{class, string, symbol, util};
use ruby_sys::types::c_char;
use ruby_sys::value::RubySpecialConsts::Nil;

pub use ruby_sys::types::{CallbackPtr, Value};
pub const RB_NIL: Value = Value { value: Nil as usize };

//
// Helper functions for dealing with Ruby and CStrings
//

#[inline(always)]
fn str_to_cstrp(s: &str) -> *const c_char {
  CString::new(s).unwrap().as_ptr()
}

#[inline]
pub fn rbstr_to_str<'a>(s: *const Value) -> &'a str {
  unsafe {
    let c_strp = string::rb_string_value_cstr(s);
    CStr::from_ptr(c_strp).to_str().unwrap()
  }
}

pub fn str_to_sym(s: &str) -> Value {
  let c_strp = str_to_cstrp(s);
  unsafe {
    let id = util::rb_intern(c_strp);
    symbol::rb_id2sym(id)
  }
}

pub fn define_module(name: &str) -> Value {
  let c_strp = str_to_cstrp(name);
  unsafe { class::rb_define_module(c_strp) }
}

pub fn define_module_under(parent: &Value, name: &str) -> Value {
  let c_strp = str_to_cstrp(name);
  unsafe { class::rb_define_module_under(*parent, c_strp) }
}

pub fn define_method(module: &Value, name: &str, method: CallbackPtr, argc: i32) {
  let c_strp = str_to_cstrp(name);
  unsafe { class::rb_define_method(*module, c_strp, method, argc) }
}

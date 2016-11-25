use std::ffi::{CStr, CString};

use ruby_sys::{class, string, symbol, util};
use ruby_sys::value::RubySpecialConsts::Nil;

pub use ruby_sys::types::{CallbackPtr, Value};
pub const RB_NIL: Value = Value { value: Nil as usize };

//
// Helper functions/macros for dealing with Ruby and CStrings
//

macro_rules! cstr {
  ($s:ident) => { CString::new($s).unwrap() }
}

macro_rules! cstrp {
  ($s:ident) => { cstr!($s).as_ptr() }
}

pub fn rbstr_to_str<'a>(s: *const Value) -> &'a str {
  unsafe {
    let c_strp = string::rb_string_value_cstr(s);
    CStr::from_ptr(c_strp).to_str().unwrap()
  }
}

pub fn str_to_sym(s: &str) -> Value {
  unsafe {
    let id = util::rb_intern(cstrp!(s));
    symbol::rb_id2sym(id)
  }
}

pub fn define_module(name: &str) -> Value {
  unsafe { class::rb_define_module(cstrp!(name)) }
}

pub fn define_module_under(parent: &Value, name: &str) -> Value {
  unsafe { class::rb_define_module_under(*parent, cstrp!(name)) }
}

pub fn define_method(module: &Value, name: &str, method: CallbackPtr, argc: i32) {
  unsafe { class::rb_define_method(*module, cstrp!(name), method, argc) }
}

pub fn extend_object(object: &Value, module: &Value) {
  unsafe { class::rb_extend_object(*object, *module) }
}

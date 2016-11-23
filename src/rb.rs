use std::ffi::{CStr, CString};

use ruby_sys::{class, string, symbol, util};
use ruby_sys::value::RubySpecialConsts::Nil;

pub use ruby_sys::types::{CallbackPtr, Value};
pub const RB_NIL: Value = Value { value: Nil as usize };

//
// Helper functions for dealing with Ruby and CStrings
//

fn str_to_cstr(s: &str) -> CString {
  CString::new(s).unwrap()
}

pub fn rbstr_to_str<'a>(s: *const Value) -> &'a str {
  unsafe {
    let c_strp = string::rb_string_value_cstr(s);
    CStr::from_ptr(c_strp).to_str().unwrap()
  }
}

pub fn str_to_sym(s: &str) -> Value {
  let c_str = str_to_cstr(s);
  unsafe {
    let id = util::rb_intern(c_str.as_ptr());
    symbol::rb_id2sym(id)
  }
}

pub fn define_module(name: &str) -> Value {
  let c_str = str_to_cstr(name);
  unsafe { class::rb_define_module(c_str.as_ptr()) }
}

pub fn define_module_under(parent: &Value, name: &str) -> Value {
  let c_str = str_to_cstr(name);
  unsafe { class::rb_define_module_under(*parent, c_str.as_ptr()) }
}

pub fn define_method(module: &Value, name: &str, method: CallbackPtr, argc: i32) {
  let c_str = str_to_cstr(name);
  unsafe { class::rb_define_method(*module, c_str.as_ptr(), method, argc) }
}

pub fn extend_object(object: &Value, module: &Value) {
  unsafe { class::rb_extend_object(*object, *module) }
}

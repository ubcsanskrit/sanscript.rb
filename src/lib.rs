#[macro_use] extern crate lazy_static;
#[macro_use] extern crate ruru;
extern crate unicode_normalization;
extern crate regex;

use ruru::{AnyObject, Class, NilClass, Symbol, RString};
use ruru::traits::Object;
#[allow(unused_imports)] use unicode_normalization::UnicodeNormalization;
use regex::Regex;

methods! {
  Class,
  _itself,
  fn detect(s: RString) -> AnyObject {
    lazy_static! {
      // # Match escaped control characters
      static ref RE_ESCAPED_CONTROL_CHAR: Regex = Regex::new(r"\\(?:\{#|##|#\})").unwrap();

      // # Match ##...## or {#...#} control blocks.
      static ref RE_CONTROL_BLOCK: Regex = Regex::new(r"##.*?##|\{#.*?#\}").unwrap();

      // Match any character in the block of Brahmic scripts
      // between Devanagari and Malayalam.
      static ref RE_BRAHMIC_RANGE: Regex = Regex::new(r"[\x{0900}-\x{0d7f}]").unwrap();

      // Match on special Roman characters
      static ref RE_IAST_OR_KOLKATA_ONLY: Regex = Regex::new(r"(?i)[āīūṛṝḷḹēōṃḥṅñṭḍṇśṣḻ]").unwrap();

      // Match on Kolkata-specific Roman characters
      static ref RE_KOLKATA_ONLY: Regex = Regex::new(r"(?i)[ēō]").unwrap();

      // Match on ITRANS-only
      static ref RE_ITRANS_ONLY: Regex = Regex::new(r"ee|oo|\^[iI]|RR[iI]|L[iI]|~N|N\^|Ch|chh|JN|sh|Sh|\.a").unwrap();

      // Match on SLP1-only characters and bigrams
      static ref RE_SLP1_ONLY: Regex = Regex::new(r"[fFxXEOCYwWqQPB]|kz|N[kg]|tT|dD|S[cn]|[aAiIuUeo]R|G[yr]").unwrap();

      // Match on Velthuis-only characters
      static ref RE_VELTHUIS_ONLY: Regex = Regex::new(r"\.[mhnrlntds]|\x22n|~s").unwrap();

      // Match on chars shared by ITRANS and Velthuis
      static ref RE_ITRANS_OR_VELTHUIS_ONLY: Regex = Regex::new(r"aa|ii|uu|~n").unwrap();

      // Match on characters available in Harvard-Kyoto
      static ref RE_HARVARD_KYOTO: Regex = Regex::new(r"[aAiIuUeoRMHkgGcjJTDNtdnpbmyrlvzSsh]").unwrap();

      static ref _DEVANAGARI: Symbol = Symbol::new("devanagari");
      static ref _BENGALI: Symbol = Symbol::new("bengali");
      static ref _GURMUKHI: Symbol = Symbol::new("gurmukhi");
      static ref _GUJARATI: Symbol = Symbol::new("gujarati");
      static ref _ORIYA: Symbol = Symbol::new("oriya");
      static ref _TAMIL: Symbol = Symbol::new("tamil");
      static ref _TELUGU: Symbol = Symbol::new("telugu");
      static ref _KANNADA: Symbol = Symbol::new("kannada");
      static ref _MALAYALAM: Symbol = Symbol::new("malayalam");
      static ref _IAST: Symbol = Symbol::new("iast");
      static ref _KOLKATA: Symbol = Symbol::new("kolkata");
      static ref _ITRANS: Symbol = Symbol::new("itrans");
      static ref _SLP1: Symbol = Symbol::new("slp1");
      static ref _VELTHUIS: Symbol = Symbol::new("velthuis");
      static ref _HK: Symbol = Symbol::new("hk");
      static ref _NIL: NilClass = NilClass::new();
    }

    let r_replaced_str = &RE_ESCAPED_CONTROL_CHAR.replace_all(&s.to_string(), "");
    let r_str = &RE_CONTROL_BLOCK.replace_all(r_replaced_str, "");

    // Brahmic schemes are all within a specific range of code points.
    let brahmic_match = RE_BRAHMIC_RANGE.find(r_str);
    if brahmic_match != None {
      let brahmic_match = brahmic_match.unwrap();
      let brahmic_codepoint = r_str.chars().nth(brahmic_match.0).unwrap() as u32;

      if brahmic_codepoint < 0x0980 {
        return _DEVANAGARI.to_any_object();
      } else if brahmic_codepoint < 0x0A00 {
        return _BENGALI.to_any_object();
      } else if brahmic_codepoint < 0x0A80 {
        return _GURMUKHI.to_any_object();
      } else if brahmic_codepoint < 0x0B00 {
        return _GUJARATI.to_any_object();
      } else if brahmic_codepoint < 0x0B80 {
        return _ORIYA.to_any_object();
      } else if brahmic_codepoint < 0x0C00 {
        return _TAMIL.to_any_object();
      } else if brahmic_codepoint < 0x0C80 {
        return _TELUGU.to_any_object();
      } else if brahmic_codepoint < 0x0D00 {
        return _KANNADA.to_any_object();
      } else {
        return _MALAYALAM.to_any_object();
      }
    }

    // Romanizations
    if RE_IAST_OR_KOLKATA_ONLY.is_match(r_str) {
      if RE_KOLKATA_ONLY.is_match(r_str) {
        return _KOLKATA.to_any_object();
      } else {
        return _IAST.to_any_object();
      }
    } else if RE_ITRANS_ONLY.is_match(r_str) {
      return _ITRANS.to_any_object();
    } else if RE_SLP1_ONLY.is_match(r_str) {
      return _SLP1.to_any_object();
    } else if RE_VELTHUIS_ONLY.is_match(r_str) {
      return _VELTHUIS.to_any_object();
    } else if RE_ITRANS_OR_VELTHUIS_ONLY.is_match(r_str) {
      return _ITRANS.to_any_object();
    } else if RE_HARVARD_KYOTO.is_match(r_str) {
      return _HK.to_any_object();
    }
    return _NIL.to_any_object();
  }
}

#[no_mangle]
pub extern fn init_rusty_sanscript() {
  Class::from_existing("RustySanscriptDetect").define(|itself| {
    itself.def("rust_detect_scheme", detect);
  });
}

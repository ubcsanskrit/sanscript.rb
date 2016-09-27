pub mod ruby;

use regex::Regex;

//
// Initialize all of the generic static variables
//
lazy_static! {
  // Match escaped control characters
  static ref RE_ESCAPED_CONTROL_CHAR: Regex = Regex::new(r"\\(?:\{#|##|#\})").unwrap();

  // Match ##...## or {#...#} control blocks.
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
}

//
// The function itself!
//
#[no_mangle]
pub extern fn detect_scheme(s: &str) -> usize {
  // Clean-up string of control characters.
  let r_str = &RE_CONTROL_BLOCK.replace_all(
                &RE_ESCAPED_CONTROL_CHAR.replace_all(s, ""), "");

  // Brahmic schemes are all within a specific range of code points.
  let brahmic_match = RE_BRAHMIC_RANGE.find(r_str);
  if brahmic_match != None {
    let brahmic_match = brahmic_match.unwrap();
    let brahmic_codepoint = r_str.chars().nth(brahmic_match.0).unwrap() as usize;

    if brahmic_codepoint < 0x0980 {
      return 1; // Devanagari
    } else if brahmic_codepoint < 0x0A00 {
      return 2; // Bengali
    } else if brahmic_codepoint < 0x0A80 {
      return 3; // Gurmukhi
    } else if brahmic_codepoint < 0x0B00 {
      return 4; // Gujarati
    } else if brahmic_codepoint < 0x0B80 {
      return 5; // Oriya
    } else if brahmic_codepoint < 0x0C00 {
      return 6; // Tamil
    } else if brahmic_codepoint < 0x0C80 {
      return 7; // Telugu
    } else if brahmic_codepoint < 0x0D00 {
      return 8; // Kannada
    } else {
      return 9; // Malayalam
    }
  }

  // Romanizations
  if RE_IAST_OR_KOLKATA_ONLY.is_match(r_str) {
    if RE_KOLKATA_ONLY.is_match(r_str) {
      return 11; // Kolkata
    } else {
      return 10; // IAST
    }
  } else if RE_ITRANS_ONLY.is_match(r_str) {
    return 12; // ITRANS
  } else if RE_SLP1_ONLY.is_match(r_str) {
    return 13; // SLP1
  } else if RE_VELTHUIS_ONLY.is_match(r_str) {
    return 14; // Velthuis
  } else if RE_ITRANS_OR_VELTHUIS_ONLY.is_match(r_str) {
    return 12; // ITRANS
  } else if RE_HARVARD_KYOTO.is_match(r_str) {
    return 15; // HK
  }
  return 0; // Unknown
}

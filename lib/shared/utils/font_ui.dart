import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontStyleUI {
  static TextStyle fontPlusJakartaSans() {
    return GoogleFonts.plusJakartaSans().copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.black);
  }
}
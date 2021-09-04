import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  Widget simpleText(String str,
      {double? fontSize = 12, Color? color = Colors.black, FontWeight? fontWeight = FontWeight.normal}) {
    return Text(str, style: GoogleFonts.montserrat(fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}

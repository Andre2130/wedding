import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
class FlutterFlowTheme {
  static const Color primaryColor = Color(0xFFEEB111);
  static const Color secondaryColor = Color(0xFFBA8C10);
  static const Color tertiaryColor = Color(0xFF14181B);

  static const Color darkText = Color(0xFFFFFFFF);
  static const Color pageBackground = Color(0xFFF1F4F8);
  static const Color grayIcon = Color(0xFF95A1AC);
  static const Color lightText = Color(0xFFFFFFFF);
  static const Color darkLines = Color(0xFF262D34);
  static const Color lightLines = Color(0xFFDEE2E7);

  String primaryFontFamily = 'Poppins';
  String secondaryFontFamily = 'Roboto';
  static TextStyle get title1 => GoogleFonts.getFont(
        'Montserrat',
        color: darkText,
        fontWeight: FontWeight.w500,
        fontSize: 32,
      );
  static TextStyle get title2 => GoogleFonts.getFont(
        'Poppins',
        color: darkText,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      );
  static TextStyle get title3 => GoogleFonts.getFont(
        'Open Sans',
        color: darkText,
        fontWeight: FontWeight.w500,
        fontSize: 24,
      );
  static TextStyle get subtitle1 => GoogleFonts.getFont(
        'Cormorant Garamond',
        color: darkText,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  static TextStyle get subtitle2 => GoogleFonts.getFont(
        'Cormorant Garamond',
        color: primaryColor,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  static TextStyle get bodyText1 => GoogleFonts.getFont(
        'Cormorant Garamond',
        color: darkLines,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
  static TextStyle get bodyText2 => GoogleFonts.getFont(
        'Dancing Script',
        color: grayIcon,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily,
    Color color,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    bool useGoogleFonts = true,
    double lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              height: lineHeight,
            );
}

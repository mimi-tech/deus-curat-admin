import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
final fontFamily = GoogleFonts.poppins();
final secondaryFontFamily = GoogleFonts.berkshireSwash().toString();

const _fontColor = kTextColor;

final kHeadLine1Style = TextStyle(
  fontSize: kFontSize10,
  fontWeight: FontWeight.bold,
  color: kDrawerTextColor2,
);

final kHeadLine2Style = TextStyle(
  fontSize: kFontSize12,
  fontWeight: FontWeight.bold,
  color: kDrawerColor,
);

final kHeadLine4Style = TextStyle(
  fontSize: kFontSize12,
  fontWeight: FontWeight.w500,
  color: kDrawerColor,
);

final kHeadLine5Style = TextStyle(
  fontSize: kFontSize12,
  fontWeight: FontWeight.bold,
  color: kOrangeColor,
);

/// Also used for [navTitleTextStyle] CupertinoTextThemeData
final kHeadLine6Style = TextStyle(
  fontSize: kFontSize12,
  fontWeight: FontWeight.w500,
  color: kRadioColor,
);

final kBodyText1Style = TextStyle(
  fontSize: kFontSize16,
  fontWeight: FontWeight.bold,
  color: _fontColor,
);

/// Also used for [textStyle] CupertinoTextThemeData
final kBodyText2Style = TextStyle(
  fontSize: kFontSize16,
  fontWeight: FontWeight.w500,
  color: _fontColor,
);

/// Also used for [navTitleTextStyle] CupertinoTextThemeData
final kSubTitle1Style = TextStyle(
  fontSize: kFontSize16,
  fontWeight: FontWeight.bold,
  color: _fontColor,
);

final kSubTitle2Style = TextStyle(
  fontSize: kFontSize10,
  fontWeight: FontWeight.bold,
  color: kDrawerTextColor,
);

final kCaptionStyle = TextStyle(
  fontSize: kFontSize16,
  fontWeight: FontWeight.bold,
  color: kOrangeColor,
);

final kOverLineStyle = TextStyle(
  fontSize: kFontSize16,
  fontWeight: FontWeight.bold,
  color: kWhiteColor,
);

final kButtonTextStyle = TextStyle(
  fontSize: kFontSize14,
  fontWeight: FontWeight.bold,
  color: kWhiteColor,

);

final kCardTheme =  CardTheme(
shape: RoundedRectangleBorder(
    side: const BorderSide(color: Colors.transparent, width: 1.0),
borderRadius:  BorderRadius.circular(10.0))
);

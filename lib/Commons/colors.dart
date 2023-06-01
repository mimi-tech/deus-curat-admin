import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
const kStatusColor = Color(0xFF707070);
const kbgColor = Color(0xFF00c8e6);
const kTextColor = Color(0xFF4a4b63);
const kHintColor = Color(0xFFDBDBDB);
const kTextFieldBorderColor = Color(0xFFFFBB84);
const kBlackColor = Color(0xFF000000) ;
const kWhiteColor = Color(0xFFFFFFFF);
const kRedColor = Color(0xFFff502f);
const kOrangeColor = Color(0xFF00c8e6);
const kPinColor = Color(0xFFFFF7F0);
const kLightAshColor = Color(0xFF837E7E);
const kPix = Color(0xFFDBDBDB);
const kGreenColor = Color(0xFF00A86A);
const kBlueColor = Color(0xFF009FCD);
const kLogoColor = Color(0xFF461720);
const kLogoColor2 = Color(0xFFB5072F);
const kBottomColor = Color(0xFF262626);
const kProfile = Color(0xFF837E7E);
const kListTileColor = Color(0xFF2B2A2A);
const kLightBlue = Color(0xFF407DBA);
const kDividerColor = Color(0xFFDBDBDB);
const kDarkRedColor = Color(0xFFB24703);
const kSelectColor = Color(0xFFA59F9F);
const kDoneColor = Color(0xFF045C76);
const kNavyBlue = Color(0xFF004A65);
const KkGColor = Color(0xFF5A5A5A);
const kRadioColor = Color(0xFFA59F9F);
const kTurnOnBtn = Color(0xFF707070);
const kVendorBtn = Color(0xFF2E7184);
const kProgressCompleted = Color(0xFF00A86A);
const kProgressBar = Color(0xFFDDFFF2);
const kGreen = Color(0xFF1BA186);
const kYellow = Color(0xFFFFBC00);
const kLightDoneColor = Color(0xFF03A7D8);
const kCartoonColor = Color(0xFFFFE0C7);
const kLightGreen = Color(0xFFD3FFF6);
const kSeaGreen = Color(0xFF0BD8AF);
const kDarkBlue = Color(0xFF022E3B);
const kGreen2 = Color(0xFF0D6755);
const kDarkYellow = Color(0xFFF5730B);
const kSilverAppBarColor = Color(0xFF700000);
const kLighterBlue = Color(0xFF027BA8);
const kVendorBg = Color(0xFF045c76);
const kBgColor = Color(0xFFeff0f9);
const kDrawerColor = Color(0xFF100c29);
const kDrawerTextColor = Color(0xFF515276);
const kDrawerTextColor2 = Color(0xFFc4c4ce);
//const kTextColor = Color(0xFF4a4b63);



const kSkyBlue = Color(0xFF44D2F7);
const kDarkBlue2 = Color(0xFF1D2A40);
const kDullBlue = Color(0xFF054A5F);

 Brightness get currentSystemBrightness =>
    SchedulerBinding.instance.window.platformBrightness;
const pinkpurple = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  stops: [0.8, 1.0],
  colors: [Color(0XFF00c8e6), Color(0XFFffffff)],
);

const grayBack = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0XFF2E2D36), Color(0XFF11101D)],
);
const grayWhite = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFFFFF), Color(0xFFF3F2FF)],
);

const buttonGradi = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0XFF7DE7EB), Color(0XFF33BBCF)],
);

const contactGradi = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0XFF2E2D36), Color(0XFF11101D)],
);

//

BoxShadow blackColorShadow = BoxShadow(
  color: Colors.black.withAlpha(100),
  blurRadius: 12.0,
  offset: const Offset(0.0, 0.0),
);

extension ThemeExtras on ThemeData {
  Color get navBarColor => brightness == Brightness.light
      ? const Color(0xffF0F0F0)
      : const Color(0xFF00040F);

  Color get achievementColor => brightness == Brightness.light
      ? const Color(0xffffffff)
      : const Color(0xFF00040F);
  //

  Color get textColor => brightness == Brightness.light
      ? const Color(0xFF403930)
      : const Color(0xFFFFF8F2);

  Color get appLogoTextColor => brightness == Brightness.light
      ? kOrangeColor
      : const Color(0xFFFFF8F2);

  Color get appBtnTextColor => brightness == Brightness.light

      ? const Color(0xFFFFF8F2)
      : kOrangeColor;
  //

  Color get textColorIOS => brightness == Brightness.light
      ? const Color(0xFF403930)
      : const Color(0xFFFFF8F2);
  //
  Color get secondaryColor => const Color(0xFFFE53BB);
  //
  Gradient get serviceCard =>
      brightness == Brightness.light ? grayWhite : grayBack;

  //
  Gradient get contactCard =>
      brightness == Brightness.light ? grayWhite : contactGradi;
}






const MaterialColor primaryOrange = MaterialColor(
  _orangePrimaryValue,
  <int, Color>{
    50: Color(0xFFF5730B),
    100: Color(0xFFF5730B),
    200: Color(0xFFF5730B),
    300: Color(0xFFF5730B),
    400: Color(0xFFF5730B),
    500: Color(0xFFF5730B),
    600: Color(0xFFF5730B),
    700: Color(0xFFF5730B),
    800: Color(0xFFF5730B),
    900: Color(0xFFF5730B),
  },
);
const int   _orangePrimaryValue
= 0xFFF5730B;
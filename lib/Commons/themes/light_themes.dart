import 'package:deuscurat_admin/Commons/themes/input_decoration_theme.dart';
import 'package:deuscurat_admin/Commons/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';



class CustomTheme {
  static ThemeData  lightTheme() { //1
    return ThemeData( //2
        primaryColor: kOrangeColor,
        scaffoldBackgroundColor: Colors.white,

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: kDarkBlue,// 4
          elevation: 5.0,
          selectedIconTheme: IconThemeData(color: Colors.amberAccent, size: 40),
          selectedItemColor: kYellow,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedIconTheme: IconThemeData(
            color: kWhiteColor
          ),
          unselectedItemColor: kWhiteColor,
        ),

        colorScheme: ThemeData().colorScheme.copyWith(
          primary: kWhiteColor,
          secondary: kOrangeColor,
        ),
        appBarTheme:  AppBarTheme(
          elevation: 0.0,
          backgroundColor: kOrangeColor,
          iconTheme: IconThemeData(color: kWhiteColor,size: 30.0),
           titleTextStyle: TextStyle(fontWeight: FontWeight.bold,
           fontSize: kFontSize16
           )
        ),
        fontFamily: GoogleFonts.oxanium().fontFamily,

       tabBarTheme: TabBarTheme(

            indicatorSize: TabBarIndicatorSize.tab,
              // indicator: const BoxDecoration(color: Colors.transparent,
              // border: Border.symmetric(horizontal: BorderSide(color: kWhiteColor))
              // ),
             labelColor: kWhiteColor,
             unselectedLabelColor: kCartoonColor,
             labelStyle:  TextStyle(fontWeight: FontWeight.bold,fontSize: kFontSize14),
             unselectedLabelStyle:  TextStyle(fontWeight: FontWeight.w500,fontSize: kFontSize14),
         overlayColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
           if (states.contains(MaterialState.pressed)) {
             return kWhiteColor;
           } if (states.contains(MaterialState.focused)) {
             return Colors.orange;
           } else if (states.contains(MaterialState.hovered)) {
             return Colors.pinkAccent;
           }

           return Colors.transparent;
         }),

       ),


        inputDecorationTheme: kInputDecorationTheme(),
         textTheme:  TextTheme(
           displayLarge: kHeadLine1Style,
           displayMedium: kHeadLine2Style,
           headlineMedium: kHeadLine4Style,
           headlineSmall: kHeadLine5Style,
           titleLarge: kHeadLine6Style,
           bodyLarge: kBodyText1Style,
           bodyMedium: kBodyText2Style,
           titleMedium: kSubTitle1Style,
           titleSmall: kSubTitle2Style,
           bodySmall: kCaptionStyle,
           labelSmall: kOverLineStyle,
           labelLarge: kButtonTextStyle,
         ),
        cardTheme: kCardTheme,
        dividerColor: kRadioColor,
        hintColor: kHintColor,
        //errorColor: kRedColor,

        // dialogBackgroundColor: Colors.blue,

        iconTheme: const IconThemeData(size: 25.0),
        listTileTheme:const ListTileThemeData(textColor: kBlackColor,selectedColor: kOrangeColor),
          popupMenuTheme: PopupMenuThemeData(textStyle: TextStyle(color: kBlackColor,fontSize: kFontSize13,fontWeight: FontWeight.bold))
    );
  }
}
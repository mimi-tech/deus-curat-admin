import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:flutter/material.dart';



InputDecorationTheme kInputDecorationTheme() {
  return InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
    filled: true,
    fillColor: kWhiteColor,
    enabledBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: kTextFieldBorderColor,
      ),
    ),
    focusedBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: kOrangeColor,
      ),
    ),
    focusedErrorBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(
        width: 0.0,
        color: kRedColor,
      ),
    ),
    contentPadding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),

    errorBorder:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(
        width: 1.0,
        color: kRedColor,
      ),
    ),
    hintStyle: TextStyle(
      fontSize: kFontSize16,
      color: kHintColor,
    ),
    labelStyle: TextStyle(
      fontSize: kFontSize16,
      color: kRadioColor,
    ),
    errorStyle: TextStyle(
      fontSize: kFontSize13,
      color: kRedColor,
    ),
  );
}


import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:deuscurat_admin/Presentation/Menus/Testimony/uploadSuccessAnimation.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:flutter/material.dart';

class SubmittedPaymentSuccess{
  static showPaymentSuccess(context){

    showDialog(
        context: context,
        builder: (context) =>

            SimpleDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                title: Text("Donation".toUpperCase(),
                    textAlign: TextAlign.center,

                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,fontSize: kFontSize14)),
                children:  <Widget>[
                  spacing(),
                  const UploadSuccessAnimation(),
                  spacing(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: Responsive.isDesktop(context)?500:MediaQuery.of(context).size.width,
                      child: Text("Testimony Created Successfully. Amazing God thank you.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: kFontSize14)),
                    ),
                  ),

                  spacing(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GeneralButton(title: "Close",color: Colors.red,textColor:kWhiteColor, tapStudiesButton: ()=>Navigator.pop(context),),

                      spacing(),

                    ],
                  ),

                ]
            ));
  }
}
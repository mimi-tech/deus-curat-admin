import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class GeneralButton extends StatelessWidget {
  const GeneralButton({Key? key,
    required this.title,
    required this.tapStudiesButton,
    this.color,
    this.textColor,

  }) : super(key: key);
  final String title;
  final VoidCallback tapStudiesButton;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Responsive(
      desktop: DesktopButton(title: title, tapStudiesButton: tapStudiesButton, color: color,textColor: textColor,),
      tablet: TabButton(title: title, tapStudiesButton: tapStudiesButton, color: color,textColor: textColor,),
      mobile: MobileButton(title: title, tapStudiesButton: tapStudiesButton, color: color,textColor: textColor,),
    );
  }}

class DesktopButton extends StatelessWidget {
  const DesktopButton({Key? key,
    required this.title,
    required this.tapStudiesButton,
    this.color,
    this.textColor,

  }) : super(key: key);
  final String title;
  final VoidCallback tapStudiesButton;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: tapStudiesButton,
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),

          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 10.0.sp,vertical: 15.0.sp),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color??kOrangeColor)),
      child:Text(title.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor??kWhiteColor)),
    );
  }}


class TabButton extends StatelessWidget {
  const TabButton({Key? key,
    required this.title,
    required this.tapStudiesButton,
    this.color,
    this.textColor,

  }) : super(key: key);
  final String title;
  final VoidCallback tapStudiesButton;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: tapStudiesButton,
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),

          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 50.0.sp,vertical: 15.0.sp),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color??kOrangeColor)),
      child:Text(title.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge),
    );
  }}

class MobileButton extends StatelessWidget {
  const MobileButton({Key? key,
    required this.title,
    required this.tapStudiesButton,
    this.color,
    this.textColor,

  }) : super(key: key);
  final String title;
  final VoidCallback tapStudiesButton;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: tapStudiesButton,
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),

          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 50.0.sp,vertical: 15.0.sp),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color??kOrangeColor)),
      child:Text(title.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge),
    );
  }}


class LoadingButton extends StatelessWidget {
  const LoadingButton({Key? key,
    this.tapStudiesButton,
    this.color,
    this.textColor,

  }) : super(key: key);
  final VoidCallback? tapStudiesButton;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(

        onPressed: tapStudiesButton,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0))),

          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal:70.sp,vertical: 15.sp),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color??Colors.transparent),

        ),
        child:const CircularProgressIndicator(color: kWhiteColor,)
    );
  }}

class GeneralButtonOutlined extends StatelessWidget{
const GeneralButtonOutlined({Key? key,
required this.title,
required this.tapStudiesButton,
this.color,
this.textColor,

}) : super(key: key);
final String title;
final VoidCallback tapStudiesButton;
final Color? color;
final Color? textColor;
@override
Widget build(BuildContext context) {
  return OutlinedButton(

    onPressed: tapStudiesButton,
    style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),

        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 10.0.sp,vertical: 15.0.sp),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(color??Colors.transparent)),
    child:Text(title.toUpperCase(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor??kOrangeColor)),
  );
}}
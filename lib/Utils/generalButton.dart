import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class GeneralButton extends StatelessWidget {
  const GeneralButton({super.key,
    required this.title,
    required this.tapStudiesButton,
    this.color,
    this.textColor,

  });
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
  const DesktopButton({super.key,
    required this.title,
    required this.tapStudiesButton,
    this.color,
    this.textColor,

  });
  final String title;
  final VoidCallback tapStudiesButton;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: tapStudiesButton,
      style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),

          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 50.0,vertical: 25.0),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(color??kOrangeColor)),
      child:Text(title.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor??kWhiteColor)),
    );
  }}


class TabButton extends StatelessWidget {
  const TabButton({super.key,
    required this.title,
    required this.tapStudiesButton,
    this.color,
    this.textColor,

  });
  final String title;
  final VoidCallback tapStudiesButton;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: tapStudiesButton,
      style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),

          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 10.0.sp,vertical: 15.0.sp),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(color??kOrangeColor)),
      child:Text(title.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge),
    );
  }}

class MobileButton extends StatelessWidget {
  const MobileButton({super.key,
    required this.title,
    required this.tapStudiesButton,
    this.color,
    this.textColor,

  });
  final String title;
  final VoidCallback tapStudiesButton;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: tapStudiesButton,
      style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),

          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 10.0.sp,vertical: 15.0.sp),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(color??kOrangeColor)),
      child:Text(title.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge),
    );
  }}


class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key,
    this.tapStudiesButton,
    this.color,
    this.textColor,

  });
  final VoidCallback? tapStudiesButton;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(

        onPressed: tapStudiesButton,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0))),

          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal:50,vertical: 20),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(color??Colors.transparent),

        ),
        child:const CircularProgressIndicator(color: kWhiteColor,)
    );
  }}

class GeneralButtonOutlined extends StatelessWidget{
const GeneralButtonOutlined({super.key,
required this.title,
required this.tapStudiesButton,
this.color,
this.textColor,

});
final String title;
final VoidCallback tapStudiesButton;
final Color? color;
final Color? textColor;
@override
Widget build(BuildContext context) {
  return OutlinedButton(

    onPressed: tapStudiesButton,
    style: ButtonStyle(
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),

        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 50.0,vertical: 15.0),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(color??Colors.transparent)),
    child:Text(title.toUpperCase(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor??kOrangeColor)),
  );
}}
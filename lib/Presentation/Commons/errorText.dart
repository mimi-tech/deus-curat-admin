
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:flutter/material.dart';
class ErrorText extends StatelessWidget {
  const ErrorText({Key? key,this.title}) : super(key: key);
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title!.toString().toUpperCase(), style: TextStyle(fontSize: kFontSize12,color: Colors.red,fontWeight: FontWeight.w500),));
  }
}

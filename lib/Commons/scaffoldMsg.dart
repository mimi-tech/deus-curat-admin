import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:flutter/material.dart';

class ScaffoldMsg{
  errorMsg(context, title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title, style: Theme
          .of(context)
          .textTheme
          .bodySmall!
          .copyWith(color: kRedColor),),
      duration: const Duration(seconds: 1),
    ));
  }

  successMsg(context, title){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title,style:  Theme.of(context).textTheme.caption!.copyWith(color: kGreen),),
      duration: const Duration(seconds: 5),

    ));
  }
}
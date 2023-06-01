import 'dart:io';
import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class ShowProgressIndicator extends StatelessWidget {
  const ShowProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !kIsWeb?const Center(child: CupertinoActivityIndicator(
      animating: true,
      radius: 30,
    ))
        :const Center(child: CircularProgressIndicator(backgroundColor: kOrangeColor,));

  }
}

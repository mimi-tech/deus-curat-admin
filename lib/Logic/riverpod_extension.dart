import 'package:deuscurat_admin/Utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showSnackbarOnError(BuildContext context) {
    if (!isRefreshing && hasError) {
      FlutterToastFunction().getToast(title: error.toString(),color: Colors.red);
    }
  }
}

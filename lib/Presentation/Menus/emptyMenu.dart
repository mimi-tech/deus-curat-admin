import 'package:flutter/material.dart';
class EmptyMenu extends StatelessWidget {
  const EmptyMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Data not found"),
    );
  }
}

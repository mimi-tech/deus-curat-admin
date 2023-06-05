import 'package:deuscurat_admin/Models/needyModel.dart';
import 'package:deuscurat_admin/Models/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';

Widget space()=>SizedBox(height: 60.0.h);
Widget spacing()=>SizedBox(height: 20.0.h);
dynamic day  = DateTime.now().day;
dynamic month  = DateTime.now().month;
dynamic year  = DateTime.now().year;
dynamic weekDay  = DateTime.now().weekday;
dynamic week = Jiffy.now().weekOfYear;

String nairaSign = "₦";

class Constant{

}
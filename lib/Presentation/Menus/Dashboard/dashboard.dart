import 'dart:math';

import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Models/commonModel.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/currency%20Format.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class DashBoard extends StatelessWidget {
   DashBoard({Key? key, required this.commons}) : super(key: key);
   final List<CommonsModel>? commons;

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spacing(),
        Text("Dashboard".toUpperCase(),style: theme.bodyLarge,),
        const Divider(),

        Wrap(
          spacing: 5.sp,
          runSpacing: 10.sp,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            CardWidget(title: "Total Donation",color: kOrangeColor.withOpacity(0.2),amount: commons![0].totalDonation,),
            CardWidget(title: "Yearly Donation",color: Colors.purpleAccent.withOpacity(0.2),amount: commons![0].year == year ?commons![0].yearlyDonation:0,),
            CardWidget(title: "This Month Donation",color: Colors.pink.withOpacity(0.2),amount:
            commons![0].year == year && commons![0].month == month
            ?commons![0].monthlyDonation:0,),
            CardWidget(title: "This Week Donation",color: kLightGreen,amount:
            commons![0].year == year && commons![0].week == week
                ?commons![0].weeklyDonation
                :0,
            ),
            CardWidget(title: "Today",color: kLightGreen,amount:
            commons![0].year == year && commons![0].month == month && commons![0].day == day
            ?commons![0].dailyDonation
              :0,
            )
          ],


    ),


    ],
    );
  }
}


class CardWidget extends StatelessWidget {
  const CardWidget({Key? key,

    this.color,
    this.title,
    this.amount
  }) : super(key: key);
final Color? color;
final String? title;
final dynamic amount;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context).textTheme;
    List<int> numbers = List.generate(10, (index) => Random().nextInt(9) + 1);
    return  SizedBox(
      //width: width * 0.2,
      child: GestureDetector(
        child: Card(
          elevation: 5.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacing(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title!,style: theme.displayLarge,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${formatCurrency(amount)}",style: theme.bodyLarge,),
              ),

              SizedBox(
                height: 100,
                width: Responsive.isDesktop(context)?width * 0.17:width,
                child: SfSparkAreaChart(
                  data: numbers,
                  axisLineColor: Colors.grey,
                  //axisLineThickness: 2,
                  color: color!,
                  borderColor: color!,
                  borderWidth: 2,

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


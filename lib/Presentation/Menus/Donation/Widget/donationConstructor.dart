import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Presentation/Commons/imageDisplay.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/currency%20Format.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
class DonationConstructor extends StatelessWidget {
  const DonationConstructor({Key? key,
  this.firstName,
  this.lastName,
  this.phoneNumber,
  this.createdAt,
  this.gender,
  this.amount,
  this.accepted,
    required this.prove
 
  }) : super(key: key);
final String? firstName;
final String? lastName;
final String? phoneNumber;
final dynamic createdAt;
final String? gender;
final String? amount;
final bool? accepted;
final String? prove;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double widthSize = width * 0.3;
    return Container(
      width:!Responsive.isDesktop(context)?width:widthSize,
      color: kWhiteColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0, bottom: 30.0),
        child: Column(
          children: [
            spacing(),
            Container(
              height: 50.h,
              width: 50.w,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kOrangeColor
              ),
              child: Center(child: Text("${firstName!.substring(0,1)} ${lastName!.substring(0,1)}",style: theme.labelSmall,)),
            ),
            spacing(),
            Text("${firstName!} ${lastName!}",style: theme.titleMedium,),
            Text(DateFormat("EEEE MMM, d yyyy h:ma").format(DateTime.parse(createdAt??DateTime.now().toString())),style: theme.titleLarge,),
            Text("$phoneNumber",style: theme.headlineMedium,),
            Text("$gender",style: theme.headlineMedium,),
            spacing(),
            Text(amount.toString(),style: theme.bodySmall),
            spacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GeneralButton(title: "Delete", tapStudiesButton: (){},color: kRedColor,),
                const SizedBox(width: 10,),
                accepted == true
                    ?const Icon(Icons.check,color: kGreenColor)
                    :GeneralButton(title: "Accept", tapStudiesButton: (){}),

                InkWell(
                    onTap: (){showFullImage(prove,context);},
                    child: Text("Prove",style: theme.titleSmall!.copyWith(color: kLightBlue),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

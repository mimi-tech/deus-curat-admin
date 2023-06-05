import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/payment.dart';
import 'package:deuscurat_admin/Models/userModel.dart';
import 'package:deuscurat_admin/Presentation/Menus/Users/userDetailsDialog.dart';
import 'package:deuscurat_admin/Presentation/Request/widgets/requestWidget.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/progressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
class AdminWidget extends ConsumerWidget {
  const AdminWidget({Key? key,required this.adminUsers}) : super(key: key);
   final List<NewUser>? adminUsers;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myChangeNotifier = ref.watch(myChangeNotifierProvider);
    var theme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    return myChangeNotifier.usersPayment.isEmpty?const ShowProgressIndicator():ListView.builder(
        itemCount: adminUsers!.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
    itemBuilder: ( context, index){
    var data = adminUsers![index];
    List<PaymentModel> userPayment = [];

    return  Container(
      width: width * 0.3,
      color: kWhiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          spacing(),
          Align(
            alignment: Alignment.topRight,
            child: data.isActive == true?const Icon(Icons.check,color: kGreenColor):const Icon(Icons.close,color: kRedColor),
          ),
          Container(
            height: 50.h,
            width: 50.w,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kOrangeColor
            ),
            child: Center(child: Text("${data.firstName!.substring(0,1)} ${data.lastName!.substring(0,1)}",style: theme.labelSmall,)),
          ),
          spacing(),
          Text("${data.firstName!} ${data.lastName!}",style: theme.titleMedium,),
          Text(data.email!,style: theme.headlineMedium,),
          Text(DateFormat("EEEE MMM, d yyyy h:ma").format(DateTime.parse(data.createdAt)),style: theme.titleLarge!.copyWith(color: kDarkRedColor),),
          Text("${data.phoneNumber}",style: theme.headlineMedium,),
          Text("${data.gender}",style: theme.headlineMedium,),
          spacing(),
          NeedyDetails(title:"Contribution count",details: "${data.contributionCount}",),
          NeedyDetails(title:"Request count",details: "${data.requestCount}",),

          spacing(),

          myChangeNotifier.loading == true?const ShowProgressIndicator():IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap:(){myChangeNotifier.getBlockUser(data.userId);},
                    child: Text(data.isActive == true ?"Block User":"unblock user",style: TextStyle(color: kLightBlue,fontSize: kFontSize12),)),


                const VerticalDivider(),
                InkWell(
                    onTap:(){myChangeNotifier.getBlockUser(data.userId);},
                    child: Text("Remove admin",style: TextStyle(color: kLightBlue,fontSize: kFontSize12),)),
                const VerticalDivider(),
                InkWell(
                    onTap:(){myChangeNotifier.getDeleteUser(data.userId);},
                    child: Text("Delete User",style: TextStyle(color: kRedColor,fontSize: kFontSize12),)),
                const VerticalDivider(),
                data.contributionCount >= 1
                    ?InkWell(
                    onTap:(){
                      List<dynamic> userId = [];
                      userPayment.clear();
                      userId.clear();

                      for(var b in myChangeNotifier.usersPayment){
                        if(b.userAuthId  == data.userId && !userId.contains(b.id)){
                          if(!userPayment.contains(b)){
                            userId.add(b.id);
                            userPayment.add(b);
                          }
                        }
                      }
                      userPayment = userPayment.toSet().toList();

                      UserDetailsDialog().userDetails(context, userPayment, data);},
                    child: Text("Contributions",style: TextStyle(color: kLightBlue,fontSize: kFontSize12),))
                    :Text("No contribution")
              ],
            ),
          )
        ],
      ),
    );
    });
  }
}

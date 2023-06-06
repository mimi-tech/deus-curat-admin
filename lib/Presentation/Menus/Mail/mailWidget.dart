import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/supportModel.dart';
import 'package:deuscurat_admin/Presentation/Request/widgets/requestWidget.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/progressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
class AllMailsWidget extends ConsumerWidget {
  const AllMailsWidget({Key? key,required this.support}) : super(key: key);
   final List<SupportModel>? support;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myChangeNotifier = ref.watch(myChangeNotifierProvider);
    var theme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListView.builder(
        itemCount: support!.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
    itemBuilder: ( context, index){
    var data = support![index];


    return Column(
    children: [
       Container(
         color: kWhiteColor,

         child: Column(
           children: [
             NeedyDetails(title:"Full name",details: "${data.firstName}",),
             NeedyDetails(title:"Phone Number",details: data.phoneNumber),
             NeedyDetails(title:"Gender",details: data.gender),
             NeedyDetails(title:"Email address",details: data.email),

             spacing(),
              Text("Header",style: theme.titleMedium),
             Text(data.header,style: theme.displayMedium),
              SizedBox(height: 10.0.h,),
              Text("Message",style: theme.titleMedium),
             Text(data.message,style: theme.displayMedium),
             spacing(),
             IntrinsicHeight(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   InkWell(
                       onTap:(){
                         String? encodeQueryParameters(Map<String, String> params) {
                           return params.entries
                               .map((MapEntry<String, String> e) =>
                           '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                               .join('&');
                         }
// ···
                         final Uri emailLaunchUri = Uri(
                           scheme: 'mailto',
                           path: data.email,
                           query: encodeQueryParameters(<String, String>{
                             'subject': "From Deus Curat",
                           }),
                         );

                         launchUrl(emailLaunchUri);
                       },
                       child: Text("Reply",style: TextStyle(color: kLightBlue,fontSize: kFontSize12),)),
                   const VerticalDivider(),

                  myChangeNotifier.loading == true?const ShowProgressIndicator(): InkWell(
                       onTap: (){myChangeNotifier.getDeleteSupport(data.id);},
                       child: Text("Delete",style: TextStyle(color: kRedColor,fontSize: kFontSize12),))
                 ],
               ),
             ),
             spacing(),
           ],
         ),
       ),
      spacing()

    ],
    );
    });
  }
}

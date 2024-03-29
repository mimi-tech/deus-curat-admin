import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/needyModel.dart';
import 'package:deuscurat_admin/Models/userModel.dart';
import 'package:deuscurat_admin/Presentation/Commons/displayVideo.dart';
import 'package:deuscurat_admin/Presentation/Commons/imageDisplay.dart';
import 'package:deuscurat_admin/Presentation/Menus/emptyMenu.dart';
import 'package:deuscurat_admin/Presentation/Request/widgets/editNeedyDetails.dart';
import 'package:deuscurat_admin/Presentation/Request/widgets/requestWidget.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/progressIndicator.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
class UsersRequest extends ConsumerWidget {
  const UsersRequest({Key? key,this.user}) : super(key: key);
  final NewUser? user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double widthSize = width * 0.1;
    double heightSize = height * 0.2;
    var theme = Theme.of(context).textTheme;
    double iconSize = 15.0.sp;
    final myChangeNotifier = ref.watch(myChangeNotifierProvider);
    return user!.requestCount >= 1 ?FutureBuilder<NeedyModel>(
      future: myChangeNotifier.getARequest(user!.userId), // The future to wait for
      builder: (BuildContext context, AsyncSnapshot<NeedyModel> snapshot) {
    if(snapshot.hasData){
      NeedyModel? users = snapshot.data;
    return Container(
      color: kWhiteColor,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(),
          Center(child: Text("${users!.firstName} ${users.lastName} Request",style: Theme.of(context).textTheme.titleMedium,)),
           spacing(),
          Wrap(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageDisplay(
                height:Responsive.isMobile(context)?height * 0.2: heightSize,
                width: Responsive.isDesktop(context)?widthSize:width * 0.7,
                imageUrl:users.images.toString() ,
              ),

              Stack(
                //alignment: Alignment.center,
                children: <Widget>[
                  DisplayVideo(
                    videoUrl: users.video,
                    width: Responsive.isDesktop(context)?widthSize:width,
                    height: heightSize,
                  ),
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 5,
                    child: Center(
                      child: InkWell(
                        child:Icon(Icons.play_arrow,color: kWhiteColor,),
                      ),
                    ),
                  )

                ],
              ),
            ],
          ),

          spacing(),

          NeedyDetails(title:"Full name",details: "${users.firstName} ${users.lastName}",),
          NeedyDetails(title:"Phone Number",details: users.phoneNumber),
          NeedyDetails(title:"Gender",details: users.gender),
          NeedyDetails(title:"Email address",details: users.email),
          NeedyDetails(title:"Address",details: users.address),
          NeedyDetails(title:"Created on",details: DateFormat("EEEE,MMM DD,yyyy h:mma").format(DateTime.parse(users.createdAt))),
          NeedyDetails(title:"Approved on",details: DateFormat("EEEE,MMM DD,yyyy h:mma").format(DateTime.parse(users.approvedDate.toString()))),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){
                  }, icon:const Icon(Icons.thumb_up_alt_outlined,size: 20,)),
                  Text(users.likeCount.toString(),style: theme.headlineSmall),
                ],
              ),

              Row(
                children: [
                  IconButton(onPressed: (){

                  }, icon:const Icon(Icons.thumb_down_alt_outlined,size: 20,)),
                  Text(users.disLikeCount.toString(),style: theme.headlineSmall),
                ],
              ),

            ],
          ),

          spacing(),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text("Donated amount",style: TextStyle(color: kRadioColor,fontSize: kFontSize12),),
                    Text(users.amountPaid.toString(),
                        style: theme.headlineSmall)
                  ],
                ),
                const VerticalDivider(),

                Column(
                  children: [
                    Text("Amount needed",style: TextStyle(color: kRadioColor,fontSize: kFontSize12),),
                    Text(users.amountNeeded.toString(),
                        style: theme.headlineSmall),
                  ],
                )
              ],
            ),
          ),
          spacing(),
          Text(users.title.toString(),style: theme.displayMedium),
          spacing(),
          ReadMoreText(users.description.toString(),
            trimLines: 2,
            style:theme.headlineMedium,
            colorClickableText: kOrangeColor,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' Show more',
            trimExpandedText: ' Show less',
            lessStyle:  TextStyle(fontSize: kFontSize12,color: kOrangeColor),
            moreStyle: TextStyle(fontSize:kFontSize12 ,color: kOrangeColor),
          ),
          spacing(),
          Wrap(
            spacing: width * 0.03,
            runSpacing: height * 0.01,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              AllRequestsHeader(
                title: 'Approved',
                icon: users.approvalStatus == true
                    ? Icon(Icons.check,color: kGreenColor,size: iconSize,)
                    : Icon(Icons.close,color: kRedColor,size: iconSize,),
              ),
              const VerticalDivider(),
              AllRequestsHeader(
                title: 'Rejected',
                icon: users.rejectStatus == true
                    ? Icon(Icons.check,color: kGreenColor,size: iconSize,)
                    : Icon(Icons.close,color: kRedColor,size: iconSize,),
              ),
              const VerticalDivider(),
              AllRequestsHeader(
                title: 'Shown',
                icon: users.showStatus == true
                    ? Icon(Icons.check,color: kGreenColor,size: iconSize,)
                    : Icon(Icons.close,color: kRedColor,size: iconSize,),
              ),
              const VerticalDivider(),
              AllRequestsHeader(
                title: 'Displaying',
                icon: users.displayStatus == true
                    ? Icon(Icons.check,color: kGreenColor,size: iconSize,)
                    : Icon(Icons.close,color: kRedColor,size: iconSize,),
              ),
            ],
          ),
          spacing(),
        ],
      ),
    );
    }
    if(snapshot.hasError){
    return const EmptyMenu();
    }
    return const Center(child: CircularProgressIndicator());
    }

    ): Text("");

  }


}

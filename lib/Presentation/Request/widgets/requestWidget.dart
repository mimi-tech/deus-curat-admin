import 'package:cached_network_image/cached_network_image.dart';
import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/appNotifier.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/needyModel.dart';
import 'package:deuscurat_admin/Presentation/Commons/displayVideo.dart';
import 'package:deuscurat_admin/Presentation/Commons/imageDisplay.dart';
import 'package:deuscurat_admin/Presentation/Menus/Needy/needyDonorsWidget.dart';
import 'package:deuscurat_admin/Presentation/Request/widgets/createTestimony.dart';
import 'package:deuscurat_admin/Presentation/Request/widgets/editNeedyDetails.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:deuscurat_admin/Utils/progressIndicator.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';
class RequestWidget extends ConsumerStatefulWidget {
   const RequestWidget({Key? key,required this.needy}) : super(key: key);
final List<NeedyModel>? needy;

  @override
   _RequestWidgetState createState() => _RequestWidgetState();

}

class _RequestWidgetState extends ConsumerState<RequestWidget> {
   VideoPlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double widthSize = width * 0.2;
    double heightSize = height * 0.2;
    double iconSize = 15.0.sp;
    final myChangeNotifier = ref.watch(myChangeNotifierProvider);
    final screenType = ref.watch(screenTypeProvider);

    var theme = Theme.of(context).textTheme;
    return myChangeNotifier.requestPayments.isEmpty?const ShowProgressIndicator():
    myChangeNotifier.loading == true?const ShowProgressIndicator(): ListView.builder(
        itemCount: widget.needy!.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
    itemBuilder: ( context, index){
      List<NeedyModel> list = [ widget.needy![index]];
    return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      Responsive.isDesktop(context)? Row(

          // spacing: 5.sp,
          // runSpacing: 10.sp,
          // alignment: WrapAlignment.spaceBetween,
          // crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageDisplay(
                height:Responsive.isMobile(context)?height * 0.1: heightSize,
                width: Responsive.isDesktop(context)?widthSize:width * 0.7,
                imageUrl:widget.needy![index].images,
              ),


              Stack(
                //alignment: Alignment.center,
                children: <Widget>[
                  DisplayVideo(
                    videoUrl: widget.needy![index].video,
                    width: widthSize,
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
          SizedBox(width: 10.w,),

          Container(
            margin: EdgeInsets.only(left: 10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                spacing(),

                NeedyDetails(title:"Full name",details: "${widget.needy![index].firstName} ${widget.needy![index].lastName}",),
                NeedyDetails(title:"Phone Number",details: widget.needy![index].phoneNumber),
                NeedyDetails(title:"Gender",details: widget.needy![index].gender),
                NeedyDetails(title:"Email address",details: widget.needy![index].email),
                NeedyDetails(title:"Address",details: widget.needy![index].address),
                NeedyDetails(title:"Created on",details: DateFormat("EEEE,MMM DD,yyyy h:mma").format(DateTime.parse(widget.needy![index].createdAt))),
                NeedyDetails(title:"Approved on",details: DateFormat("EEEE,MMM DD,yyyy h:mma").format(DateTime.parse(widget.needy![index].approvedDate.toString()))),

                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){
                        }, icon:const Icon(Icons.thumb_up_alt_outlined,size: 20,)),
                        Text(widget.needy![index].likeCount.toString(),style: theme.headlineSmall),
                      ],
                    ),

                    Row(
                      children: [
                        IconButton(onPressed: (){

                        }, icon:const Icon(Icons.thumb_down_alt_outlined,size: 20,)),
                        Text(widget.needy![index].disLikeCount.toString(),style: theme.headlineSmall),
                      ],
                    ),

                  ],
                ),


                spacing(),
                IntrinsicHeight(
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Donated amount",style: TextStyle(color: kRadioColor,fontSize: kFontSize12),),
                          Text(widget.needy![index].amountPaid.toString(),
                              style: theme.headlineSmall)
                        ],
                      ),
                      const VerticalDivider(),

                      Column(
                        children: [
                          Text("Amount needed",style: TextStyle(color: kRadioColor,fontSize: kFontSize12),),
                          Text(widget.needy![index].amountNeeded.toString(),
                              style: theme.headlineSmall),
                        ],
                      )
                    ],
                  ),
                ),
                spacing(),

              ],
            ),
          ),

        ],
        )
        :Wrap(

        spacing: 5.sp,
        runSpacing: 10.sp,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageDisplay(
                height:Responsive.isMobile(context)?height * 0.2: heightSize,
                width: Responsive.isDesktop(context)?widthSize:width,
                imageUrl:widget.needy![index].images ,
              ),


              Stack(
                //alignment: Alignment.center,
                children: <Widget>[
                  DisplayVideo(
                    videoUrl: widget.needy![index].video,
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

          Container(
            margin: EdgeInsets.only(left: 10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                spacing(),

                NeedyDetails(title:"Full name",details: "${widget.needy![index].firstName} ${widget.needy![index].lastName}",),
                NeedyDetails(title:"Phone Number",details: widget.needy![index].phoneNumber),
                NeedyDetails(title:"Gender",details: widget.needy![index].gender),
                NeedyDetails(title:"Email address",details: widget.needy![index].email),
                NeedyDetails(title:"Address",details: widget.needy![index].address),
                NeedyDetails(title:"Created on",details: DateFormat("EEEE,MMM DD,yyyy h:mma").format(DateTime.parse(widget.needy![index].createdAt))),
                NeedyDetails(title:"Approved on",details: DateFormat("EEEE,MMM DD,yyyy h:mma").format(DateTime.parse(widget.needy![index].approvedDate.toString()))),

                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){
                        }, icon:const Icon(Icons.thumb_up_alt_outlined,size: 20,)),
                        Text(widget.needy![index].likeCount.toString(),style: theme.headlineSmall),
                      ],
                    ),

                    Row(
                      children: [
                        IconButton(onPressed: (){

                        }, icon:const Icon(Icons.thumb_down_alt_outlined,size: 20,)),
                        Text(widget.needy![index].disLikeCount.toString(),style: theme.headlineSmall),
                      ],
                    ),

                  ],
                ),


                spacing(),
                IntrinsicHeight(
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Donated amount",style: TextStyle(color: kRadioColor,fontSize: kFontSize12),),
                          Text(widget.needy![index].amountPaid.toString(),
                              style: theme.headlineSmall)
                        ],
                      ),
                      const VerticalDivider(),

                      Column(
                        children: [
                          Text("Amount needed",style: TextStyle(color: kRadioColor,fontSize: kFontSize12),),
                          Text(widget.needy![index].amountNeeded.toString(),
                              style: theme.headlineSmall),
                        ],
                      )
                    ],
                  ),
                ),
                spacing(),

              ],
            ),
          ),

        ],
      ),
        spacing(),
        Text(widget.needy![index].title.toString(),style: theme.displayMedium),
        spacing(),
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: Responsive.isDesktop(context)?width * 0.07:width,
            maxWidth: Responsive.isDesktop(context)?width * 0.4:width,

          ),
          child: ReadMoreText(widget.needy![index].description.toString(),
            trimLines: 13,
            style:theme.headlineMedium,
            colorClickableText: kOrangeColor,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' Show more',
            trimExpandedText: ' Show less',
            lessStyle:  TextStyle(fontSize: kFontSize12,color: kOrangeColor),
            moreStyle: TextStyle(fontSize:kFontSize12 ,color: kOrangeColor),
          ),
        ),
        spacing(),

        myChangeNotifier.loading == true?const ShowProgressIndicator():IntrinsicHeight(
          child: Wrap(

            spacing: width * 0.03,
            runSpacing: height * 0.01,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Header(title: widget.needy![index].approvalStatus == true?"Disapprove":"Approve",onTap: (){
                ref.read(myChangeNotifierProvider).getUpdateNeedStatus(widget.needy![index].userAuthId,'approval');
                // setState(() {
                //   widget.needy!.removeAt(index);
                // });
              },tooltip: approveTooltip,),
              const VerticalDivider(),
              Header(title: widget.needy![index].rejectStatus == true?"Accept":"Reject",onTap: (){
                ref.read(myChangeNotifierProvider).getUpdateNeedStatus(widget.needy![index].userAuthId,'reject');
                // setState(() {
                //   widget.needy!.removeAt(index);
                // });

              },tooltip: rejectTooltip,),
              const VerticalDivider(),
              Header(title: "Delete",onTap: (){
                setState(() {
                  widget.needy!.removeAt(index);
                });
                ref.read(myChangeNotifierProvider).getDeleteNeedy(widget.needy![index].userAuthId);

              },tooltip: deleteTooltip,),
              const VerticalDivider(),
              Header(title: widget.needy![index].displayStatus == true?"Hide":"Display",onTap: (){
                ref.read(myChangeNotifierProvider).getUpdateNeedStatus(widget.needy![index].userAuthId,'display');
                setState(() {
                  //widget.needy!.removeAt(index);
                  myChangeNotifier.requestPayments.removeAt(index);
                });

              },tooltip: displayTooltip,),
              const VerticalDivider(),
              Header(title: "Edit request",onTap: (){

                EditDialog().showEditDialog(context: context,needy: widget.needy![index]);
              },tooltip: editTooltip,),
            ],
          ),
        ),


        spacing(),


        const Divider(),
        Wrap(
          spacing: width * 0.03,
          runSpacing: height * 0.01,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            AllRequestsHeader(
              title: 'Approved',
              icon: widget.needy![index].approvalStatus == true
                  ? Icon(Icons.check,color: kGreenColor,size: iconSize,)
                  : Icon(Icons.close,color: kRedColor,size: iconSize,),
            ),
            const VerticalDivider(),
            AllRequestsHeader(
              title: 'Rejected',
              icon: widget.needy![index].rejectStatus == true
                  ? Icon(Icons.check,color: kGreenColor,size: iconSize,)
                  : Icon(Icons.close,color: kRedColor,size: iconSize,),
            ),
            const VerticalDivider(),
            AllRequestsHeader(
              title: 'Shown',
              icon: widget.needy![index].showStatus == true
                  ? Icon(Icons.check,color: kGreenColor,size: iconSize,)
                  : Icon(Icons.close,color: kRedColor,size: iconSize,),
            ),
            const VerticalDivider(),
            AllRequestsHeader(
              title: 'Displaying',
              icon: widget.needy![index].displayStatus == true
                  ? Icon(Icons.check,color: kGreenColor,size: iconSize,)
                  : Icon(Icons.close,color: kRedColor,size: iconSize,),
            ),
          ],
        ),
        spacing(),
        SizedBox(
            height: height * 0.4,
            width: width,
            child: NeedyDonors(needyDetails: list,requestIndex: index,)),
        spacing(),
        screenType == displayedRequest

        ?myChangeNotifier.loading == true
            ?const LoadingButton()
            :GeneralButton(title: "Create Testimony", tapStudiesButton: (){CreateTestimonyDialog().showCreateTestimonyDialog(context: context,needy:widget.needy![index]);})
        :const Text(""),

        spacing(),
      ],
      ),
    ),
    );
    });
  }

}

class Header extends StatelessWidget {
  const Header({Key? key,this.title, this.onTap, this.tooltip}) : super(key: key);
final String? title;
final String? tooltip;
final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Tooltip(
            message:tooltip ,
            textStyle: Theme.of(context).textTheme.titleSmall,
            decoration:  BoxDecoration(
                color:kDrawerTextColor2.withOpacity(0.2) ),
            child: Text(title!,style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.normal,fontSize: kFontSize10),)));
  }
}


class NeedyDetails extends StatelessWidget {
  const NeedyDetails({Key? key,this.title,this.details}) : super(key: key);
  final String? title;
  final String? details;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h,),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "$title: ",
              style: Theme.of(context).textTheme.displayMedium,
              children: <TextSpan>[
                TextSpan(
                  text: details,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kDarkRedColor),

                ),


              ]

          ),
        ),
      ],
    );
  }
}

class AllRequestsHeader extends StatelessWidget {
  const AllRequestsHeader({Key? key,this.title, this.icon}) : super(key: key);
final String? title;
final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       Text(title!, style: Theme.of(context).textTheme.titleLarge,),
        icon!
      ],
    );
  }
}


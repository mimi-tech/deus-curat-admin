import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/testimonyModel.dart';
import 'package:deuscurat_admin/Presentation/Commons/imageDisplay.dart';
import 'package:deuscurat_admin/Presentation/Commons/videoPlayerWidget.dart';
import 'package:deuscurat_admin/Presentation/Request/widgets/requestWidget.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class TestimonyWidget extends ConsumerWidget {
  const TestimonyWidget({Key? key,required this.testimony}) : super(key: key);
   final List<TestimonyModel>? testimony;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double widthSize = width * 0.1;
    double heightSize = height * 0.2;
    final myChangeNotifier = ref.watch(myChangeNotifierProvider);
    var theme = Theme.of(context).textTheme;
    return ListView.builder(
        itemCount: testimony!.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
    itemBuilder: ( context, index){
          var data = testimony![index];
    return  Column(
      children: [
        Container(
          color: kWhiteColor,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Wrap(
                   children: [
                     ImageDisplay(
                       height:Responsive.isMobile(context)?height * 0.1: heightSize,
                       width: Responsive.isDesktop(context)?widthSize:width,
                       imageUrl:data.imagesBefore ,
                     ),

                     ImageDisplay(
                       height:Responsive.isMobile(context)?height * 0.1: heightSize,
                       width: Responsive.isDesktop(context)?widthSize:width,
                       imageUrl:data.imagesAfter ,
                     ),
                   ],
                 ),
                spacing(),

                NeedyDetails(title:"Full name",details: "${data.firstName} ${data.lastName}",),
                NeedyDetails(title:"Phone Number",details: data.phoneNumber),
                NeedyDetails(title:"Gender",details: data.gender),
                NeedyDetails(title:"Email address",details: data.email),
                NeedyDetails(title:"Address",details: data.address),
                NeedyDetails(title:"Created on",details: DateFormat("EEEE,MMM DD,yyyy h:mma").format(DateTime.parse(data.createdAt))),


                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){
                        }, icon:const Icon(Icons.thumb_up_alt_outlined,size: 20,)),
                        Text(data.likeCount.toString(),style: theme.headlineSmall),
                      ],
                    ),

                    Row(
                      children: [
                        IconButton(onPressed: (){

                        }, icon:const Icon(Icons.thumb_down_alt_outlined,size: 20,)),
                        Text(data.disLikeCount.toString(),style: theme.headlineSmall),
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
                          Text(data.amountPaid.toString(),
                              style: theme.headlineSmall)
                        ],
                      ),
                      const VerticalDivider(),

                      Column(
                        children: [
                          Text("Amount needed",style: TextStyle(color: kRadioColor,fontSize: kFontSize12),),
                          Text(data.amountNeeded.toString(),
                              style: theme.headlineSmall),
                        ],
                      )
                    ],
                  ),
                ),
                spacing(),
                Text(data.title.toString(),style: theme.bodyLarge),
                spacing(),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: Responsive.isDesktop(context)?width * 0.07:width,
                    maxWidth: Responsive.isDesktop(context)?width * 0.4:width,

                  ),
                  child: ReadMoreText(data.description.toString(),
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
                const Divider(),
                spacing(),
                 Text("FeedBack",
                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: kRedColor),
                 ),

                spacing(),
                Text(data.testimonyTitle.toString(),style: theme.bodyLarge),
                spacing(),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: Responsive.isDesktop(context)?width * 0.07:width,
                    maxWidth: Responsive.isDesktop(context)?width * 0.4:width,

                  ),
                  child: ReadMoreText(data.testimonyDesc.toString(),
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

                IntrinsicHeight(
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap:(){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  VideoPlayerWidget(videoUrl: data.videoBefore.toString(),)),
                          );
                          },
                          child: Text("Watch previous video",style: TextStyle(color: kOrangeColor,fontSize: kFontSize12),)),
                      const VerticalDivider(),

                      InkWell(
                          onTap:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  VideoPlayerWidget(videoUrl: data.videoAfter.toString(),)),
                            );
                          },
                          child: Text("Watch recent video",style: TextStyle(color: kOrangeColor,fontSize: kFontSize12),))
                    ],
                  ),
                ),
                spacing(),
                myChangeNotifier.loading == true
                ?const LoadingButton()
                :GeneralButton(title: "Delete", tapStudiesButton: (){myChangeNotifier.getDeleteTestimony(data.id);},color: kRedColor,)
              ],
            ),
          ),
        ),

        spacing(),
      ],
    );
    });
    }
  }


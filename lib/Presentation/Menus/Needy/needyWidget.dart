import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/appNotifier.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/needyModel.dart';
import 'package:deuscurat_admin/Presentation/Commons/videoPlayerWidget.dart';
import 'package:deuscurat_admin/Presentation/Menus/Needy/needyDonorsWidget.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:deuscurat_admin/Utils/progressIndicator.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
class NeedyWidget extends ConsumerStatefulWidget {
  const NeedyWidget({Key? key, required this.needyDetails}) : super(key: key);
  final List<NeedyModel>? needyDetails;

  @override
  _NeedyWidgetState createState() => _NeedyWidgetState();
}

class _NeedyWidgetState extends ConsumerState<NeedyWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context).textTheme;
    final myChangeNotifier = ref.watch(myChangeNotifierProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spacing(),
        Text("Approved Needy".toUpperCase(),style: theme.bodyLarge,),
        const Divider(),

        Wrap(

            spacing: 5.sp,
            runSpacing: 10.sp,
            alignment: WrapAlignment.spaceBetween,
            //crossAxisAlignment: WrapCrossAlignment.center,

            //physics: BouncingScrollPhysics(),
            //shrinkWrap: true,
            children: widget.needyDetails!.map((needs) => Wrap(
              spacing: 10.sp,
              runSpacing: 15.sp,
              //alignment: WrapAlignment.spaceBetween,
             // crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(
                      height:Responsive.isMobile(context)?height * 0.1:height * 0.2,
                      width: Responsive.isDesktop(context)?width * 0.22:width * 0.7,
                      child: CachedNetworkImage(
                        imageUrl:needs.images.toString(),
                        placeholder: (context, url) =>  Image.network("https://thumbs.dreamstime.com/b/happy-person-arms-raised-outstretched-69762123.jpg",
                          height:Responsive.isMobile(context)?height * 0.1:height * 0.2,
                          width: Responsive.isDesktop(context)?width * 0.22:width * 0.7,
                          fit: BoxFit.cover,),
                        errorWidget: (context, url, error) =>Image.network("https://thumbs.dreamstime.com/b/happy-person-arms-raised-outstretched-69762123.jpg",
                          height:Responsive.isMobile(context)?height * 0.1:height * 0.2,
                          width: Responsive.isDesktop(context)?width * 0.22:width * 0.7,
                          fit: BoxFit.cover,),
                        fit: BoxFit.cover,


                      ),
                    ),


                    Container(
                      color: kWhiteColor,
                      width: Responsive.isDesktop(context)?width * 0.22:width * 0.7,
                      height: Responsive.isTablet(context)?height * 0.65:height * 0.5,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 3.0.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(needs.title.toString(),style: theme.displayMedium),
                                Responsive.isDesktop(context)?Container():spacing(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ReadMoreText(needs.description.toString(),
                                    trimLines: 13,
                                    style:theme.headlineMedium,
                                    textAlign: TextAlign.center,
                                    colorClickableText: kOrangeColor,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: ' Show more',
                                    trimExpandedText: ' Show less',
                                    lessStyle:  TextStyle(fontSize: kFontSize12,color: kOrangeColor),
                                    moreStyle: TextStyle(fontSize:kFontSize12 ,color: kOrangeColor),
                                  ),),

                                //   child: Text(needs.description??"jebhfjwhfgw fjwhfuyf wjegugqrj rbguqygrj2r jrgu2ygrjb2r j2hgiuqgrbj gfbujhbfr hrfugrjhb j4brjrgj rbugrbunj1rb",
                                //     textAlign: TextAlign.center,style: TextStyle(fontSize:  Responsive.isDesktop(context)?kFontSize10:kMobileFontSize12),),
                                // ),
                                Responsive.isDesktop(context)?Container():spacing(),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text("Donated amount",style: TextStyle(color: kRadioColor,fontSize: kFontSize12),),
                                          Text(needs.amountPaid.toString(),
                                            style: theme.headlineSmall)
                                        ],
                                      ),
                                      const VerticalDivider(),

                                      Column(
                                        children: [
                                          Text("Amount needed",style: TextStyle(color: kRadioColor,fontSize: kFontSize12),),
                                          Text(needs.amountNeeded.toString(),
                                            style: theme.headlineSmall),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                              ],
                            ),
                            spacing(),

                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "Created on: ",
                                  style: theme.displayMedium,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: DateFormat().format(DateTime.parse(needs.createdAt)),
                                      style: theme.displayLarge,

                                    ),


                                  ]

                              ),
                            ),

                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "Approved on: ",
                                  style: theme.displayMedium,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: DateFormat().format(DateTime.parse(needs.approvedDate!)),
                                      style: theme.displayLarge,

                                    ),


                                  ]

                              ),
                            ),

                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "Address: ",
                                  style: theme.displayMedium,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: needs.address!,
                                      style: theme.displayLarge,

                                    ),


                                  ]

                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(onPressed: (){
                                    }, icon:const Icon(Icons.thumb_up_alt_outlined,size: 20,)),
                                    Text(needs.likeCount.toString(),style: theme.headlineSmall),

                                  ],
                                ),

                                Row(
                                  children: [
                                    IconButton(onPressed: (){

                                    }, icon:const Icon(Icons.thumb_down_alt_outlined,size: 20,)),
                                    Text(needs.disLikeCount.toString(),style: theme.headlineSmall),

                                  ],
                                ),

                                myChangeNotifier.loading == true?const ShowProgressIndicator():IconButton(onPressed: (){
                                  ref.read(myChangeNotifierProvider).getUpdateNeedStatus(needs.userAuthId,'display');
                                  setState(() {
                                    widget.needyDetails!.remove(needs);
                                  });

                                 }, icon: const Icon(Icons.delete,color: kRedColor,)),
                              ],
                            ),
                            //SizedBox(height: 3.sp,),
                            Center(
                              child: GeneralButton(title: "Watch video",tapStudiesButton: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  VideoPlayerWidget(
                                    videoUrl: needs.video??"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
                                  )),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),


              ],
            )
            ).toList()),
         spacing(),
         NeedyDonors(needyDetails: widget.needyDetails,)
      ],
    );
  }
}

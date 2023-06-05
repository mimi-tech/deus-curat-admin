
import 'package:cached_network_image/cached_network_image.dart';
import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/payment.dart';
import 'package:deuscurat_admin/Presentation/Commons/displayVideo.dart';
import 'package:deuscurat_admin/Presentation/Commons/imageDisplay.dart';
import 'package:deuscurat_admin/Presentation/Menus/Donation/Widget/donationConstructor.dart';
import 'package:deuscurat_admin/Presentation/Request/widgets/requestWidget.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/currency%20Format.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:deuscurat_admin/Utils/progressIndicator.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class DonationWidget extends ConsumerStatefulWidget {
  const DonationWidget({Key? key, required this.donation}) : super(key: key);
  final List<PaymentModel>? donation;
  @override
  _DonationWidgetState createState() => _DonationWidgetState();
}

class _DonationWidgetState extends ConsumerState<DonationWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double widthSize = width * 0.3;
    double heightSize = height * 0.2;
    double iconSize = 15.0.sp;
    final myChangeNotifier = ref.watch(myChangeNotifierProvider);
    var theme = Theme.of(context).textTheme;
    return myChangeNotifier.neededDonationMadeTo.isEmpty?const ShowProgressIndicator():ListView.builder(
      itemCount: widget.donation!.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
    itemBuilder: ( context, index){
        var data = widget.donation![index];
        var request = myChangeNotifier.neededDonationMadeTo[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
               children: [
                 DonationConstructor(
                    firstName: data.firstName,
                    lastName: data.lastName,
                    gender: data.gender,
                    createdAt: data.createdAt,
                    phoneNumber: data.phoneNumber,
                    amount: data.amount.toString(),
                    accepted: data.accepted,
                   prove: data.prove,
                   data: data,
                 ),

                   request == null?const Text("Request not found"): Padding(
                     padding: const EdgeInsets.only(left: 12.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           children: [

                             InkWell(
                               onTap: (){
                                 showFullImage(request.images,context);
                               },
                               child: CachedNetworkImage(
                               imageUrl: request.images.toString(),
                               imageBuilder: (context, imageProvider) =>
                               Container(
                               width: 50.0.w,
                               height: 50.0.h,
                               decoration: BoxDecoration(
                               border: Border.all(
                               width: 5.0, color:Colors.transparent,),
                               shape: BoxShape.circle,
                               image: DecorationImage(
                               image: imageProvider, fit: BoxFit.cover),
                               ),
                               ),
                               //placeholder: (context, url) => CircularProgressIndicator(),
                               placeholder: (context, url) => SvgPicture.asset('assets/user.svg'),
                                errorWidget: (context, url, error) =>
                                SvgPicture.asset('assets/user.svg'),
                                ),
                             ),

                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(request.firstName!,style: theme.titleMedium,),
                                 Text(request.lastName!,style: theme.titleMedium,),
                               ],
                             ),

                           ],
                         ),
                         SizedBox(height: 2.h,),
                         NeedyDetails(title:"Gender",details: request.gender),
                         NeedyDetails(title:"Email address",details: request.email),
                         NeedyDetails(title:"Address",details: request.address),
                         NeedyDetails(title:"Created on",details: DateFormat("EEEE,MMM DD,yyyy h:mma").format(DateTime.parse(request.createdAt))),
                         NeedyDetails(title:"Approved on",details: DateFormat("EEEE,MMM DD,yyyy h:mma").format(DateTime.parse(request.approvedDate.toString()))),
                         SizedBox(height: 2.h,),
                         Row(
                           //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Row(
                               children: [
                                 IconButton(onPressed: (){
                                 }, icon:const Icon(Icons.thumb_up_alt_outlined,size: 20,)),
                                 Text(request.likeCount.toString(),style: theme.headlineSmall),
                               ],
                             ),

                             Row(
                               children: [
                                 IconButton(onPressed: (){

                                 }, icon:const Icon(Icons.thumb_down_alt_outlined,size: 20,)),
                                 Text(request.disLikeCount.toString(),style: theme.headlineSmall),
                               ],
                             ),

                           ],
                         ),
                         SizedBox(height: 2.h,),
                         IntrinsicHeight(
                           child: Row(
                             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Column(
                                 children: [
                                   Text("Donated amount",style: TextStyle(color: kRadioColor,fontSize: kFontSize12),),
                                   Text(request.amountPaid.toString(),
                                       style: theme.headlineSmall)
                                 ],
                               ),
                               const VerticalDivider(),

                               Column(
                                 children: [
                                   Text("Amount needed",style: TextStyle(color: kRadioColor,fontSize: kFontSize12),),
                                   Text(request.amountNeeded.toString(),
                                       style: theme.headlineSmall),
                                 ],
                               )
                             ],
                           ),
                         ),
                         spacing(),

                         ConstrainedBox(
                           constraints: BoxConstraints(
                             minWidth: width * 0.07,
                             maxWidth: width * 0.4,

                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(request.title.toString(),style: theme.bodyLarge),
                               SizedBox(height: 10.0.h,),
                               ReadMoreText(request.description.toString(),
                                 trimLines: 13,
                                 style:theme.headlineMedium,
                                 colorClickableText: kOrangeColor,
                                 trimMode: TrimMode.Line,
                                 trimCollapsedText: ' Show more',
                                 trimExpandedText: ' Show less',
                                 lessStyle:  TextStyle(fontSize: kFontSize12,color: kOrangeColor),
                                 moreStyle: TextStyle(fontSize:kFontSize12 ,color: kOrangeColor),
                               ),
                             ],
                           ),
                         ),

                         Row(
                           children: [
                             Stack(
                               //alignment: Alignment.center,
                               children: <Widget>[
                                 DisplayVideo(
                                   videoUrl: request.video,
                                   width: 100,
                                   height: 100,
                                 ),


                                 const Positioned(
                                   left: 0,
                                   right: 0,
                                   bottom: 0,
                                   top: 10,
                                   child: Center(
                                     child: InkWell(
                                       child:Icon(Icons.play_arrow,color: kWhiteColor,),
                                     ),
                                   ),
                                 )

                               ],
                             ),
                             SizedBox(width: 10.w,),

                             ImageDisplay(imageUrl: request.images,height: 100,width: 100,)
                           ],
                         ),
                         spacing(),
                       ],
                     ),
                   ),


               ],
             ),
            const Divider(),
            spacing(),
          ],
        );
    });
  }
}

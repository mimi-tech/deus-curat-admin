
import 'package:cached_network_image/cached_network_image.dart';
import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/payment.dart';
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
   // final myChangeNotifier = ref.watch(myChangeNotifierProvider);
    var theme = Theme.of(context).textTheme;
    return ListView.builder(
      itemCount: widget.donation!.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
    itemBuilder: ( context, index){
        var data = widget.donation![index];
        var request = Constant.neededDonationMadeTo[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
               children: [
                 Container(
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
                           child: Center(child: Text("${data.firstName!.substring(0,1)} ${data.lastName!.substring(0,1)}",style: theme.labelSmall,)),
                         ),
                         spacing(),
                         Text("${data.firstName!} ${data.lastName!}",style: theme.titleMedium,),
                         Text(DateFormat("EEEE MMM, d yyyy h:ma").format(DateTime.parse(data.createdAt)),style: theme.titleLarge,),
                         Text("${data.phoneNumber}",style: theme.headlineMedium,),
                         Text("${data.gender}",style: theme.headlineMedium,),
                         spacing(),
                         Text(formatCurrency(data.amount),style: theme.bodySmall
                         ),
                         spacing(),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             GeneralButton(title: "Delete", tapStudiesButton: (){},color: kRedColor,),
                             const SizedBox(width: 10,),
                              data.accepted == true
                                 ?const Icon(Icons.check,color: kGreenColor)
                                 :GeneralButton(title: "Accept", tapStudiesButton: (){}),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),

                   request == null?const Text("Request not founf"): Padding(
                     padding: const EdgeInsets.only(left: 12.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           children: [
                             CachedNetworkImage(
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

                             Text(request.firstName!,style: theme.titleMedium,),
                             Text(request.lastName!,style: theme.titleMedium,),
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
                               Text(request.title.toString(),style: theme.displayMedium),
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
                                 Container(
                                   color: kBlackColor,
                                   width: 100,
                                   height: 100,),


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

                             Stack(
                               //alignment: Alignment.center,
                               children: <Widget>[
                                 Container(
                                   color: kBlackColor,
                                   width: 100,
                                   height: 100,),


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
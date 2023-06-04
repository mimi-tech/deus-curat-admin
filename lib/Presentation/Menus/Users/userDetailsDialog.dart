import 'package:cached_network_image/cached_network_image.dart';
import 'package:deuscurat_admin/Presentation/Commons/imageDisplay.dart';
import 'package:deuscurat_admin/Presentation/Menus/Donation/Widget/donationConstructor.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserDetailsDialog{

  userDetails(context, details, user){
    var theme = Theme.of(context).textTheme;
    showDialog(
        context: context,
        builder: (context) =>

        SimpleDialog(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
    ),
    elevation: 4,
     title: Center(child: Text("${user.firstName} ${user.lastName}",style: Theme.of(context).textTheme.titleMedium,)),
     children: [
       for(int index = 0; index < details.length; index++)
    Column(

      children: [

            DonationConstructor(
              firstName: details[index].firstName.toString(),
              lastName: details[index].lastName.toString(),
              gender: details[index].gender.toString(),
              createdAt: details[index].createdAt,
              phoneNumber: details[index].phoneNumber.toString(),
              amount: details[index].amount.toString(),
              accepted: details[index].accepted,

          ),


        const Text("Request Donation was made to",
        style: TextStyle(
          decoration: TextDecoration.underline
        ),
        ),
        spacing(),
        InkWell(
          onTap: (){
            showFullImage(details[index].needyImage,context);
          },
          child: CachedNetworkImage(
            imageUrl: details[index].needyImage.toString(),
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
            errorWidget: (context, url, error) => SvgPicture.asset('assets/user.svg'),
          ),
        ),
        spacing(),
        Text("${details[index].needyName}",style:theme.titleMedium ,),
        Text("${details[index].needyGender}",style:theme.headlineMedium ,),
        Text("${details[index].needyAddress}",style:theme.headlineMedium ,),
        Text("${details[index].needyTitle}",style:theme.headlineMedium ,),

        spacing(),
        Divider(),
      ],
    )
     ],
        ));
  }
}
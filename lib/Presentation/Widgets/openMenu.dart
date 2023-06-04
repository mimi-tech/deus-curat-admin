import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
class OpenMenu extends ConsumerWidget {
  const OpenMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final requestType = ref.watch(requestTypeProvider);
    final donationType = ref.watch(donationTypeProvider);
    final usersType = ref.watch(usersTypeProvider);
    var theme = Theme.of(context).textTheme;

    return Container(
      child: (
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          ListTile(
            onTap:()=>ref.read(drawerMenuProvider.notifier).state = false,
            leading: Text("Menu".toUpperCase(),style: theme.titleSmall,),
            trailing: const Icon(Icons.cancel,color: kWhiteColor,),
          ),
          const Divider(),
          ListTile(

            onTap:(){
              ref.read(screenTypeProvider.notifier).state = dashboard;
              ref.read(requestTypeProvider.notifier).state = false;
              ref.read(donationTypeProvider.notifier).state = false;
              ref.read(usersTypeProvider.notifier).state = false;
                },
            leading: const Icon(Icons.dashboard,color: kDrawerTextColor,),
            title: Text("DashBoard",style: theme.titleSmall,),
            hoverColor: kYellow,
            tileColor: kOrangeColor,
          ),

          ListTile(
            onTap:(){
               ref.read(screenTypeProvider.notifier).state = needy;
               ref.read(requestTypeProvider.notifier).state = false;
               ref.read(donationTypeProvider.notifier).state = false;
               ref.read(usersTypeProvider.notifier).state = false;
                 },

            leading: const Icon(Icons.person,color: kDrawerTextColor,),
            title: Text("Needy",style: theme.titleSmall,),
          ),

          ListTile(
            onTap: (){
              ref.read(requestTypeProvider.notifier).state = !requestType;
              ref.read(donationTypeProvider.notifier).state = false;
              ref.read(usersTypeProvider.notifier).state = false;
            },
            leading: const Icon(Icons.help,color: kDrawerTextColor,),
            title: Text("Request",style: theme.titleSmall!.copyWith(color: requestType == true ?kWhiteColor:kDrawerTextColor),),
            trailing: const Icon(Icons.arrow_drop_down,color: kDrawerTextColor,),
          ),
          if(requestType == true)
          Container(
            margin: const EdgeInsets.only(left: 10),
            color: kDrawerTextColor2,
            child: Column(
              children: [
                ListTile(
                  onTap:()=>ref.read(screenTypeProvider.notifier).state = allRequest,
                  leading: Icon(Icons.help_outline,color: kDrawerTextColor,size: 15.sp,),
                  title: Text("All request(s)",style: theme.titleSmall,),
                ),
                ListTile(
                  onTap:()=>ref.read(screenTypeProvider.notifier).state = newRequest,
                  leading: Icon(Icons.help_outline,color: kDrawerTextColor,size: 15.sp,),
                  title: Text("New request(s)",style: theme.titleSmall,),
                ),
                ListTile(
                  onTap:()=>ref.read(screenTypeProvider.notifier).state = rejectedRequest,
                  leading:  Icon(Icons.help_center_outlined,color: kDrawerTextColor,size: 15.sp),
                  title: Text("Rejected request(s)",style: theme.titleSmall,),
                ),
                ListTile(
                  onTap:()=>ref.read(screenTypeProvider.notifier).state = shownRequest,
                  leading: Icon(Icons.help_center_rounded,color: kDrawerTextColor,size: 15.sp),
                  title: Text("Showed request(s)",style: theme.titleSmall,),
                ),

                ListTile(
                  onTap:()=>ref.read(screenTypeProvider.notifier).state = displayedRequest,
                  leading: Icon(Icons.help_center_rounded,color: kDrawerTextColor,size: 15.sp),
                  title: Text("Displaying request(s)",style: theme.titleSmall,),
                ),
              ],
            ),
          ),

          ListTile(
            onTap: (){
              ref.read(donationTypeProvider.notifier).state = !donationType;
              ref.read(requestTypeProvider.notifier).state = false;
              ref.read(usersTypeProvider.notifier).state = false;
              },
            leading: const Icon(Icons.monetization_on,color: kDrawerTextColor,),
            title: Text("Donations",style: theme.titleSmall!.copyWith(color: donationType == true ?kWhiteColor:kDrawerTextColor)),
            trailing: const Icon(Icons.arrow_drop_down,color: kDrawerTextColor,),
          ),
          if(donationType == true)
          Container(
            margin: const EdgeInsets.only(left: 10),
            color: kDrawerTextColor2,
            child: Column(
              children: [
                ListTile(
                  onTap:()=>ref.read(screenTypeProvider.notifier).state = allDonation,
                  leading: Icon(Icons.monetization_on_outlined,color: kDrawerTextColor,size: 15.sp,),
                  title: Text("All Donations(s)",style: theme.titleSmall,),
                ),

                ListTile(
                  onTap:()=>ref.read(screenTypeProvider.notifier).state = acceptedDonation,
                  leading: Icon(Icons.monetization_on_outlined,color: kDrawerTextColor,size: 15.sp,),
                  title: Text("Accepted Donations(s)",style: theme.titleSmall,),
                ),

                ListTile(
                  onTap:()=>ref.read(screenTypeProvider.notifier).state = newDonation,
                  leading: Icon(Icons.monetization_on_outlined,color: kDrawerTextColor,size: 15.sp,),
                  title: Text("New Donations(s)",style: theme.titleSmall,),
                ),
              ],
            ),
          ),

          ListTile(
            onTap:() {
              ref.read(screenTypeProvider.notifier).state = testimony;

            },
            leading: const Icon(Icons.transfer_within_a_station,color: kDrawerTextColor,),
            title: Text("Testimony",style: theme.titleSmall,),
          ),

          ListTile(
            onTap: (){
              ref.read(usersTypeProvider.notifier).state = !usersType;

            },
            leading: const Icon(Icons.person_add,color: kDrawerTextColor,),
            title: Text("Users",style: theme.titleSmall!.copyWith(color: usersType == true ?kWhiteColor:kDrawerTextColor,)),
            trailing: const Icon(Icons.arrow_drop_down,color: kDrawerTextColor,),
          ),
          if(usersType == true)
          Container(
            margin: const EdgeInsets.only(left: 10),
            color: kDrawerTextColor2,
            child: Column(
              children: [
                ListTile(
                  onTap: (){
                    ref.read(screenTypeProvider.notifier).state = users;
                  },
                  leading:  Icon(Icons.person_add,color: kDrawerTextColor,size: 15.sp),
                  title: Text("All Users",style: theme.titleSmall,),

                ),

                ListTile(
                  onTap: (){
                    ref.read(screenTypeProvider.notifier).state = blockedUsers;
                  },
                  leading:  Icon(Icons.block,color: kDrawerTextColor,size: 15.sp),
                  title: Text("Blocked Users",style: theme.titleSmall,),

                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings,color: kDrawerTextColor,),
            title: Text("Admin",style: theme.titleSmall,),
          ),
          spacing(),
        ],
      )
      ),
    );
  }
}

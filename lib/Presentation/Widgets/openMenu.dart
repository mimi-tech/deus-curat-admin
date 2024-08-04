import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Presentation/Menus/counselling/counselling_repository.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
class OpenMenu extends ConsumerWidget {
  const OpenMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final requestType = ref.watch(requestTypeProvider);
    final donationType = ref.watch(donationTypeProvider);
    final usersType = ref.watch(usersTypeProvider);
    final reportType = ref.watch(reportTypeProvider);
    final screenType  = ref.watch(screenTypeProvider);
    var theme = Theme.of(context).textTheme;


    return Column(
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
            ref.read(reportTypeProvider.notifier).state = false;
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
             ref.read(reportTypeProvider.notifier).state = false;
               },

          leading: const Icon(Icons.person,color: kDrawerTextColor,),
          title: Text("Needy",style: theme.titleSmall,),
        ),

        ListTile(
          onTap: (){
            ref.read(requestTypeProvider.notifier).state = !requestType;
            ref.read(donationTypeProvider.notifier).state = false;
            ref.read(usersTypeProvider.notifier).state = false;
            ref.read(reportTypeProvider.notifier).state = false;
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
                leading: Icon(Icons.help_outline,color: kDrawerTextColor,size: 15,),
                title: Text("All request(s)",style: theme.titleSmall,),
              ),
              ListTile(
                onTap:()=>ref.read(screenTypeProvider.notifier).state = newRequest,
                leading: Icon(Icons.help_outline,color: kDrawerTextColor,size: 15,),
                title: Text("New request(s)",style: theme.titleSmall,),
              ),
              ListTile(
                onTap:()=>ref.read(screenTypeProvider.notifier).state = approvedRequest,
                leading:  Icon(Icons.help_center_outlined,color: kDrawerTextColor,size: 15),
                title: Text("Approved request(s)",style: theme.titleSmall,),
              ),

              ListTile(
                onTap:()=>ref.read(screenTypeProvider.notifier).state = rejectedRequest,
                leading:  Icon(Icons.help_center_outlined,color: kDrawerTextColor,size: 15),
                title: Text("Rejected request(s)",style: theme.titleSmall,),
              ),
              ListTile(
                onTap:()=>ref.read(screenTypeProvider.notifier).state = shownRequest,
                leading: Icon(Icons.help_center_rounded,color: kDrawerTextColor,size: 15),
                title: Text("Showed request(s)",style: theme.titleSmall,),
              ),

              ListTile(
                onTap:()=>ref.read(screenTypeProvider.notifier).state = displayedRequest,
                leading: Icon(Icons.help_center_rounded,color: kDrawerTextColor,size: 15),
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
            ref.read(reportTypeProvider.notifier).state = false;
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
                leading: Icon(Icons.monetization_on_outlined,color: kDrawerTextColor,size: 15,),
                title: Text("All Donations(s)",style: theme.titleSmall,),
              ),

              ListTile(
                onTap:()=>ref.read(screenTypeProvider.notifier).state = acceptedDonation,
                leading: Icon(Icons.monetization_on_outlined,color: kDrawerTextColor,size: 15,),
                title: Text("Accepted Donations(s)",style: theme.titleSmall,),
              ),

              ListTile(
                onTap:()=>ref.read(screenTypeProvider.notifier).state = newDonation,
                leading: Icon(Icons.monetization_on_outlined,color: kDrawerTextColor,size: 15,),
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
            ref.read(reportTypeProvider.notifier).state = false;
            ref.read(donationTypeProvider.notifier).state = false;
            ref.read(requestTypeProvider.notifier).state = false;
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
                leading:  Icon(Icons.person_add,color: kDrawerTextColor,size: 15),
                title: Text("All Users",style: theme.titleSmall,),

              ),

              ListTile(
                onTap: (){
                  ref.read(screenTypeProvider.notifier).state = blockedUsers;
                },
                leading:  Icon(Icons.block,color: kDrawerTextColor,size: 15),
                title: Text("Blocked Users",style: theme.titleSmall,),

              ),
            ],
          ),
        ),

        ListTile(
          onTap: (){
            ref.read(requestTypeProvider.notifier).state = false;
            ref.read(usersTypeProvider.notifier).state = false;
            ref.read(reportTypeProvider.notifier).state = false;
            ref.read(screenTypeProvider.notifier).state = admin;
          },
          leading: const Icon(Icons.admin_panel_settings,color: kDrawerTextColor,),
          title: Text("Admin",style: theme.titleSmall,),
        ),


        ListTile(
          onTap: (){
            ref.read(requestTypeProvider.notifier).state = false;
            ref.read(usersTypeProvider.notifier).state = false;
            ref.read(reportTypeProvider.notifier).state = false;
            ref.read(screenTypeProvider.notifier).state = mail;
          },
          leading: const Icon(Icons.mail,color: kDrawerTextColor,),
          title: Text("Mail",style: theme.titleSmall,),
        ),

        ListTile(
          onTap:(){
        ref.read(reportTypeProvider.notifier).state = !reportType;
        ref.read(usersTypeProvider.notifier).state = false;
        ref.read(donationTypeProvider.notifier).state = false;
        ref.read(requestTypeProvider.notifier).state = false;
        },
        leading: const Icon(Icons.report_problem,color: kDrawerTextColor,size: 15,),
        title: Text("Christ comfort",style: theme.titleSmall!.copyWith(color: reportType == true ?kWhiteColor:kDrawerTextColor)),

        trailing: const Icon(Icons.arrow_drop_down,color: kDrawerTextColor,),
        ),
        if(reportType == true)
        Container(
        color: kDrawerTextColor2,
        margin: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                ListTile(
                  onTap:(){
                    ref.read(screenTypeProvider.notifier).state = counselling;
                   ref.read(counseleeProvider.notifier).executeFunction(counselling);

                    },
                  leading: Text("1",style: theme.titleSmall,),
                  title: Text("All Counselees",style: theme.titleSmall,),
                ),

                ListTile(
                  onTap:(){
    ref.read(screenTypeProvider.notifier).state = newCounselee;
    ref.read(counseleeProvider.notifier).executeFunction(newCounselee);
    },
    leading: Text("2",style: theme.titleSmall,),
    title: Text("New Counselees",style: theme.titleSmall,),
    ),

    ListTile(
    onTap:(){
    ref.read(screenTypeProvider.notifier).state = replayedCounselee;
    ref.read(counseleeProvider.notifier).executeFunction(replayedCounselee);
    },
    leading: Text("3",style: theme.titleSmall,),
    title: Text("Replied Counselees",style: theme.titleSmall,),
    ),


    ListTile(
    onTap:(){
    ref.read(screenTypeProvider.notifier).state = notAcceptedCounselee;

    ref.read(counseleeProvider.notifier).executeFunction(notAcceptedCounselee);
    },
    leading: Text("4",style: theme.titleSmall,),
    title: Text("Not accepted Counselees",style: theme.titleSmall,),
    )

              ],
            ),
          ),
        spacing(),
      ],
    );

  }
}

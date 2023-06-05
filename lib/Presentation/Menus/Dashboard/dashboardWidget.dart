import 'dart:math';

import 'package:deuscurat_admin/Logic/appNotifier.dart';
import 'package:deuscurat_admin/Presentation/Menus/Dashboard/dashboard.dart';
import 'package:deuscurat_admin/Presentation/Menus/Dashboard/highestDonors.dart';
import 'package:deuscurat_admin/Presentation/Menus/emptyMenu.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/currency%20Format.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
class DashboardWidget extends ConsumerWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    dynamic testimonyCount;
    dynamic requestCount;
    dynamic usersCount;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ref.watch(getCommons).when(
            loading: () => const Center(child: Text('Loading...')),
            data: (commons) {
              testimonyCount = commons[0].testimonyCount;
              requestCount = commons[0].requestCount;
              usersCount = commons[0].usersCount;
              return commons.isEmpty?const EmptyMenu():DashBoard(commons: commons,);
            },
            error: (error, stackTrace) {
              debugPrint(error.toString());
              return   const EmptyMenu();
            },
          ),
          spacing(),
          ref.watch(getHighestDonors).when(
            loading: () => const Center(child: Text('Loading...')),
            data: (donors) =>donors.isEmpty?const EmptyMenu():HighestDonors(donors: donors,testimonyCount:testimonyCount,requestCount:requestCount,usersCount: usersCount,),
            error: (error, stackTrace) {
              debugPrint(error.toString());
              return   const EmptyMenu();
            },
          ),


        ],
      ),
    );
  }
}


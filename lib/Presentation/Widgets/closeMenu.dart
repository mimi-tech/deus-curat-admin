import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
class CloseMenu extends ConsumerWidget {
  const CloseMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context).textTheme;
    return Container(
      child: (
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               IconButton(onPressed: (){ref.read(drawerMenuProvider.notifier).state = true;}, icon: const Icon(Icons.menu_open,color: kWhiteColor,),),

               IconButton(onPressed: (){}, icon: const Icon(Icons.dashboard,color: kDrawerTextColor,),),
               IconButton(onPressed: (){}, icon: const Icon(Icons.person,color: kDrawerTextColor,),),
               IconButton(onPressed: (){}, icon: const Icon(Icons.help,color: kDrawerTextColor,),),
               IconButton(onPressed: (){}, icon: const Icon(Icons.monetization_on,color: kDrawerTextColor,),),
               IconButton(onPressed: (){}, icon: const Icon(Icons.transfer_within_a_station,color: kDrawerTextColor,),),
               IconButton(onPressed: (){}, icon: const Icon(Icons.person_add,color: kDrawerTextColor,),),
               IconButton(onPressed: (){}, icon: const Icon(Icons.admin_panel_settings,color: kDrawerTextColor,),),
               IconButton(onPressed: (){}, icon: const Icon(Icons.report_problem_outlined,color: kDrawerTextColor,),),

              spacing(),
            ],
          )
      ),
    );
  }
}

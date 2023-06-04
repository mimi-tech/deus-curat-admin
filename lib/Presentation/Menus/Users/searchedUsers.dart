import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Presentation/Menus/Users/usersWidget.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/progressIndicator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
class SearchedUsers extends ConsumerWidget {
  const SearchedUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myChangeNotifier = ref.watch(myChangeNotifierProvider);
    var theme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final screenType = ref.watch(screenTypeProvider);
    return myChangeNotifier.loading == true ? const ShowProgressIndicator():myChangeNotifier.searchedUsers.isEmpty?
    Center(
      child: Text("User not found",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kRedColor),),
    )
        :ListView(
      children: [
        spacing(),

        Text(screenType.toString().toUpperCase(),style: theme.bodyLarge,),
        spacing(),
        Text(myChangeNotifier.errorText.toString(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kRedColor),),
        UsersWidget(users: myChangeNotifier.searchedUsers,),
      ],
    );
  }
}

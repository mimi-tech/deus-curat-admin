import 'package:deuscurat_admin/Logic/appNotifier.dart';
import 'package:deuscurat_admin/Presentation/Menus/Needy/needyWidget.dart';
import 'package:deuscurat_admin/Presentation/Menus/emptyMenu.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
class Needy extends ConsumerWidget {
  const Needy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        ref.watch(getNeedy).when(
          loading: () => const Center(child: Text('Loading...')),
          data: (needy) =>needy.isEmpty?const EmptyMenu():NeedyWidget(needyDetails: needy,),
          error: (error, stackTrace) {
            debugPrint(error.toString());
            return   const EmptyMenu();
          },
        ),
      ],
    );
  }
}

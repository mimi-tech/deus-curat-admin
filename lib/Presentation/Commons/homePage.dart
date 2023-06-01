
import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/sharedPreference.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Presentation/Commons/appLogo.dart';
import 'package:deuscurat_admin/Presentation/Menus/Dashboard/dashboardWidget.dart';
import 'package:deuscurat_admin/Presentation/Menus/Needy/needy.dart';
import 'package:deuscurat_admin/Presentation/Request/newRequest.dart';
import 'package:deuscurat_admin/Presentation/Widgets/closeMenu.dart';
import 'package:deuscurat_admin/Presentation/Widgets/openMenu.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context).textTheme;
    final drawerType = ref.watch(drawerMenuProvider);
    final screenType = ref.watch(screenTypeProvider);
    final fullName = useState("");
    final screenWidth = useState(MediaQuery.of(context).size.width);
    useEffect(() {
      // Use an effect to asynchronously retrieve the full name
      UserPreferences().getFullName().then((value) {
        fullName.value = value.toString(); // Update the value of fullName
      });
      if(width <= 1000){
        ref.read(drawerMenuProvider.notifier).state = false;
      }else{
        ref.read(drawerMenuProvider.notifier).state = true;
      }
      return;

    }, [width]);
    Widget? screen;

      switch (screenType) {
        case dashboard:
          screen = const DashboardWidget();
          break;
        case needy:
          screen =  const Needy();
          break;
        case allRequest:
          screen = const NewRequest();
          break;
        case newRequest:
          screen = const NewRequest();

          break;
        case rejectedRequest:
          screen = const NewRequest();
          break;
        case displayedRequest:
          screen = const NewRequest();
          break;
        case shownRequest:
          screen = const NewRequest();
          break;
        default:
          print('Selected fruit is unknown');
      }


    return Scaffold(
        appBar: AppBar(
          backgroundColor: kWhiteColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const NavBarLogo(),
              Container(
                height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: kOrangeColor,
                    shape: BoxShape.circle
                  ),
                  child: Center(child: Text(fullName.value.toString().toUpperCase(),style: theme.labelSmall)))
            ],
          )
        ),
        body: Stack(
          children: [
            Align(
                //alignment: Alignment.center,
                // BG01.png
                child: Container(color: kBgColor,
                  height: height,
                  width: width,
                  child: Container(
                      margin: EdgeInsets.only(left:drawerType == true? width * 0.2: width * 0.1,right: width * 0.06),
                      child: screen
                  ),
                )
            ),
           Positioned(
             top: 0,
               left: 0,
               bottom: 0,

               child: Responsive.isDesktop(context)?Container(
                 height: height,
                 width: drawerType == true?width * 0.15:width * 0.06,
                 color: kDrawerColor,
                 child: drawerType == true?const OpenMenu():const CloseMenu(),
               )
                   :Container(
                 height: height,
                 width: drawerType == true?width * 0.3:width * 0.09,
                 color: kDrawerColor,
                 child: drawerType == true?const OpenMenu():const CloseMenu(),
               )

           )

          ],
        ));
  }
}

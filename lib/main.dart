import 'package:beamer/beamer.dart';
import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/themes/light_themes.dart';
import 'package:deuscurat_admin/Logic/sharedPreference.dart';
import 'package:deuscurat_admin/Presentation/Commons/LoginScreen.dart';
import 'package:deuscurat_admin/Presentation/Commons/homePage.dart';
import 'package:deuscurat_admin/Presentation/Commons/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( ProviderScope(
      child: MyApp()));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        // Return either Widgets or BeamPages if more customization is needed
        '/': (context, state, data) => const SplashScreen(),
        '/home': (context, state, data) =>  const HomePage(),
        '/login': (context, state, data) => LoginScreen(),
      },
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: kWhiteColor, //status bar color
        systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light, //navigation bar icons' color
        statusBarBrightness: Brightness.light, // Dark == white status bar -- for IOS.
      ),
    );
    return ScreenUtilInit(

        designSize: const Size(360, 740),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext contexts, child) {

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Deus Curat Admin',
            theme:  CustomTheme.lightTheme(),
            routeInformationParser: BeamerParser(),
            routerDelegate: routerDelegate,
            backButtonDispatcher: BeamerBackButtonDispatcher(delegate: routerDelegate),

          );
        });
  }
}


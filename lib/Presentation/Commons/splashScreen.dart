import 'package:beamer/beamer.dart';
import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Logic/sharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    startTime();
    super.initState();
  }

  startTime() async {
    await Future.delayed(const Duration(seconds: 2)).then((value)  {
      UserPreferences().getToken().then((value) {
        if(value == ""){
          Beamer.of(context).beamToNamed('/login');
        }else{
          Beamer.of(context).beamToNamed('/home');
        }
      });


    });

  }
  @override
  Widget build(BuildContext context) {
    //ScreenUtil.init(context, designSize: const Size(360, 690));
    return Container(
      color: kOrangeColor,
      child:Center(child: Image.asset("assets/charity1.gif",height: 100,width: 100,fit: BoxFit.cover,)),
    );
  }
}

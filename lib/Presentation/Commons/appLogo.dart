import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarLogo extends StatelessWidget {
  const NavBarLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // theme
    var theme = Theme.of(context);
    //

    return SvgPicture.asset('assets/app_logo.svg',height: 26,width: 26,);
    // return Image.asset("assets/imgs/app_logo.png",
    // height: Responsive.isDesktop(context)?40.h:100.h,
    // width: Responsive.isDesktop(context)? 40.w:100.w,
    // fit: BoxFit.cover,
    // );
  }
}

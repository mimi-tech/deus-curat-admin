
import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FlutterToastFunction{
  getToast({color,title}){
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: color,
        textColor: kWhiteColor,
        fontSize: kFontSize14
    );
  }


}
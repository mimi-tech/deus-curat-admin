import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginationFunction{

  Widget nextDocument({required documentLength, required loadNextDocument, required loadPrevDocument, required pageNumber}){
    if(documentLength >= 15 &&  pageNumber == 1 ){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0.sp))),

                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 50.0.sp,vertical: 10.0.sp),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent)),
              onPressed:  loadNextDocument, child: const Text("Next",style: TextStyle(color: kBlackColor))),
        ],
      );
    }else if(documentLength >= 15 &&  pageNumber > 1){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0))),

                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 50.0.sp,vertical: 10.0.sp),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent)),
              onPressed:loadPrevDocument, child: const Text("Prev",style:  TextStyle(color: kBlackColor))),
          OutlinedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0.sp))),

                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 50.0.sp,vertical: 10.0.sp),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent)),
              onPressed: loadNextDocument, child: const Text("Next",style: TextStyle(color: kBlackColor))),
        ],
      );
    }else if (documentLength <= 15 &&  pageNumber > 1){
      return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0))),

                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 50.0.sp,vertical: 10.0.sp),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent)),
              onPressed:loadPrevDocument, child: const Text("Prev",style:  TextStyle(color: kBlackColor))),
        ],
      );
    }else{
      return Text("");
    }



  }
}
import 'package:flutter/material.dart';

class SubmittedPaymentLoading{
  static showPaymentLoading(context){

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) =>

            SimpleDialog(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                children:  <Widget>[
                  Center(child: Image.asset("assets/gif/loading4.gif",height: 150,width: 150,fit: BoxFit.cover,)),
                ]
            ));
  }
}
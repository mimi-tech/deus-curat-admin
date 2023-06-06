import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Logic/appNotifier.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:deuscurat_admin/Utils/validation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ComposeDialog{
  showComposeDialog(context){
    final TextEditingController _email = TextEditingController();
    final TextEditingController _header = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var theme = Theme.of(context).textTheme;
    String? email;
    String? header;

    showDialog(
        context: context,
        builder: (context) =>

            SimpleDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 4,
                title: Text("Create Admin".toUpperCase(),
                  style: theme.displayMedium,
                  textAlign: TextAlign.center,),
                children: <Widget>[


                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: Responsive.isDesktop(context)?20.sp:50.sp),
                      child: SizedBox(
                        width: Responsive.isDesktop(context)?500:MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            spacing(),

                            TextFormField(
                              controller: _email,
                              autofocus: true,
                              cursorColor: (kOrangeColor),
                              keyboardType: TextInputType.emailAddress,
                              style: Theme.of(context).textTheme.bodyLarge,
                              validator: Validator.validateField,
                              decoration:  InputDecoration(
                                hintText: "Enter user email address",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                              ),
                              onSaved: (String? value) {
                                email = value!;
                              },
                            ),

                            spacing(),

                            TextFormField(
                              controller: _header,
                              autofocus: true,
                              cursorColor: (kOrangeColor),
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              maxLength: 50,
                              style: Theme.of(context).textTheme.bodyLarge,
                              validator: Validator.validateField,
                              decoration:  InputDecoration(
                                hintText: "Enter email header",
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                              ),
                              onSaved: (String? value) {
                                header = value!;
                              },
                            ),
                            spacing(),

                          ],
                        ),
                      ),
                    ),
                  ),
                  spacing(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GeneralButton(color: kRedColor,title: "Cancel", tapStudiesButton: (){
                        Navigator.pop(context);
                      }),
                      GeneralButton(title: "Send", tapStudiesButton: (){
                        final form = _formKey.currentState;
                        if (!form!.validate()) {
                          return;
                        }
                        form.save();
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        String? encodeQueryParameters(Map<String, String> params) {
                          return params.entries
                              .map((MapEntry<String, String> e) =>
                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                              .join('&');
                        }
// ···
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: _email.text.trim(),
                          query: encodeQueryParameters(<String, String>{
                            'subject': _header.text.trim(),
                          }),
                        );

                        launchUrl(emailLaunchUri);
                        Navigator.pop(context);


                      }),
                    ],
                  )
                ]
            ));
  }
}

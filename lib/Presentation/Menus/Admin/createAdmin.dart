import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Logic/appNotifier.dart';
import 'package:deuscurat_admin/Logic/pickimages.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:deuscurat_admin/Utils/toast.dart';
import 'package:deuscurat_admin/Utils/validation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAdminDialog{
  showCreateAdminDialog(context){
    final TextEditingController _email = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var theme = Theme.of(context).textTheme;
    String? email;

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
                      margin: EdgeInsets.symmetric(horizontal: Responsive.isDesktop(context)?20:50),
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
                      GeneralButton(title: "Create Admin", tapStudiesButton: (){
                        final form = _formKey.currentState;
                        if (!form!.validate()) {
                          return;
                        }
                        form.save();
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                          MyChangeNotifier().getCreateAdmin(_email.text.trim());
                          Navigator.pop(context);


                      }),
                    ],
                  )
                ]
            ));
  }
}

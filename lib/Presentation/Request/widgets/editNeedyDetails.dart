import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Logic/appNotifier.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:deuscurat_admin/Utils/toast.dart';
import 'package:deuscurat_admin/Utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditDialog{
  showEditDialog({context, needy}){
    final TextEditingController _title = TextEditingController();
    final TextEditingController _desc = TextEditingController();
    final TextEditingController _amount = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var theme = Theme.of(context).textTheme;
    String? title;
    String? desc;
    String? amount;

      showDialog(
          context: context,
          builder: (context) =>

              SimpleDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  title: Text("${needy.firstName} ${needy.lastName} Needy Details".toUpperCase(),
                    style: theme.displayMedium,
                    textAlign: TextAlign.center,),
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(

                        "You can edit the needy details to be more understanding to people",textAlign: TextAlign.center,

                      ),
                    ),
                      const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Title: ${needy.title}",style: theme.displayMedium),
                    ),
                     SizedBox(height: 5.h,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          width: Responsive.isDesktop(context)?500:MediaQuery.of(context).size.width,
                          child: Text("Description: ${needy.description}",style: theme.headlineMedium,)),
                    ),
                    spacing(),
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
                                controller: _title,
                                autocorrect: true,
                                autofocus: true,
                                textCapitalization: TextCapitalization.sentences,
                                maxLength: 50,
                                maxLines: null,

                                cursorColor: (kOrangeColor),
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.bodyLarge,
                                validator: Validator.validateField,
                                decoration:  InputDecoration(
                                  hintText: "Enter title",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                                ),
                                onSaved: (String? value) {
                                  title = value!;
                                },
                              ),

                              spacing(),
                              TextFormField(
                                controller: _desc,
                                autocorrect: true,
                                autofocus: true,
                                cursorColor: (kOrangeColor),
                                maxLength: 500,
                                maxLines: null,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.sentences,
                                style: Theme.of(context).textTheme.bodyLarge,
                                validator: Validator.validateField,
                                decoration:  InputDecoration(
                                    hintText: "Enter description",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                                ),
                                onSaved: (String? value) {
                                  desc = value!;
                                },
                              ),

                              spacing(),
                              TextFormField(
                                controller: _amount,
                                autocorrect: true,
                                autofocus: true,
                                cursorColor: (kOrangeColor),
                                maxLength: 50,
                                maxLines: null,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.sentences,
                                style: Theme.of(context).textTheme.bodyLarge,
                                validator: Validator.validateAmount,
                                decoration:  InputDecoration(
                                    hintText: "Enter the  Amount Needed",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onSaved: (String? value) {
                                  amount = value!;
                                },
                              ),

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
                        GeneralButton(title: "Update", tapStudiesButton: (){
                          final form = _formKey.currentState;
                          if (!form!.validate()) {
                            return;
                          }
                          form.save();
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if(_desc.text.length > 490){
                            FlutterToastFunction().getToast(title: "Description must be up 500 characters",color: kRedColor);
                          }else{
                            MyChangeNotifier().getUpdateNeedyDetails(_title.text, _desc.text, int.parse(_amount.text), needy.userAuthId);
                            Navigator.pop(context);
                          }

                        }),
                      ],
                    )
                  ]
              ));
    }
  }

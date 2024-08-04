import 'package:beamer/beamer.dart';
import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/appNotifier.dart';
import 'package:deuscurat_admin/Logic/riverpod_extension.dart';
import 'package:deuscurat_admin/Presentation/Commons/errorText.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:deuscurat_admin/Utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
   LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email;

  String? password;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      authProvider, (_, state) => state.showSnackbarOnError(context),
    );
    final authState = ref.watch(authProvider);

    var errorText = authState.error;
    return Scaffold(
        backgroundColor: kOrangeColor,
        body: ListView(
      children: [
        space(),
        space(),
        space(),
        space(),
        (authState.hasError)?ErrorText(title: errorText.toString(),):const Text(""),
        Wrap(
        //mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5.sp,
        runSpacing: 10.sp,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(helloTag,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          Image.asset('assets/hi.gif', height: 40),
        ],
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context)?400:kMargin,
            //vertical: MediaQuery.of(context).size.height * 0.2
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [

                spacing(),

                TextFormField(
                  controller: _email,
                  autocorrect: true,
                  autofocus: true,
                  cursorColor: (kOrangeColor),
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.bodyLarge,
                  validator: Validator.validateEmail,
                  decoration: const InputDecoration(
                    hintText: "Enter email address",

                  ),
                  onSaved: (String? value) {
                    email = value!;
                  },
                ),

                spacing(),

                TextFormField(
                  controller: _password,
                  autocorrect: true,
                  autofocus: true,
                  obscureText: true,
                  cursorColor: (kOrangeColor),
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.bodyLarge,
                  validator: Validator.validatePassword,
                  decoration: const InputDecoration(
                    hintText: "Enter password",

                  ),
                  onSaved: (String? value) {
                    password = value!;
                  },
                ),

              ],
            ),
          ),
        ),

        spacing(),
        (authState.isLoading)
            ?const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingButton(),
          ],
        ):
        Center(child: GeneralButton(title: "Login",tapStudiesButton: (){

          final form = _formKey.currentState;
          if (!form!.validate()) {
            return;
          }
          form.save();
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          ref.read(authProvider.notifier).login(_email.text.trim(), _password.text.trim()).then((value){
            if(value == true){
              Beamer.of(context).beamToNamed('/home');
            }
          });

        },color: kWhiteColor,textColor: kOrangeColor,))
      ],
    ));
  }
}

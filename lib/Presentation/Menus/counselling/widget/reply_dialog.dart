import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Models/counselee_model.dart';
import 'package:deuscurat_admin/Presentation/Menus/counselling/counselling_repository.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


Future<void> showEditReplyDialog(BuildContext context, CounseleeModel counselee, WidgetRef ref, List<CounseleeModel> allCounselee) async {
  final formKey = GlobalKey<FormState>();
  final TextEditingController replyController = TextEditingController();
  final counseleeState = ref.watch(counseleeProvider);
  print(counseleeState.counselees.length);
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Reply for ${counselee.name}'),
        content: Column(
          children: [

            Form(
              key: formKey,
              child: TextFormField(
                controller: replyController,
                decoration: const InputDecoration(labelText: 'Reply'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a reply';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        actions: [
          GeneralButton(title: "Cancel", tapStudiesButton: (){
            Navigator.of(context).pop()  ;
          }),
         GeneralButton(title: "Submit", tapStudiesButton: () async {
             if (formKey.currentState?.validate() != true) {
               return;
             }

             showDialog(
               context: context,
               barrierDismissible: false,
               builder: (BuildContext context) {
                 return const Center(child: CircularProgressIndicator());
               },
             );


               ref.read(counseleeProvider.notifier).updateCounselee(counselee, replyController.text, allCounselee).then((result) async {

                 Navigator.of(context).pop();
                 Navigator.of(context).pop();

               });

              // Navigator.of(context).pop(); // Close the progress dialog



          }),


        ],
      );
    },
  );
}

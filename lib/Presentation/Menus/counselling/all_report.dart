import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/counselee_model.dart';
import 'package:deuscurat_admin/Presentation/Menus/counselling/widget/reply_dialog.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'counselling_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllReport extends ConsumerStatefulWidget {
  const AllReport({super.key});

  @override
  _AllReportState createState() => _AllReportState();
}

class _AllReportState extends ConsumerState<AllReport> {
  var screenType;
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () {
          //final screenType = ref.watch(screenTypeProvider);
          ref.read(counseleeProvider.notifier).executeFunction(screenType);
        }
    );
  }
  Future<void> _editReply(CounseleeModel counselee, List<CounseleeModel> allCounselee) async {
  await showEditReplyDialog(context, counselee, ref, allCounselee);

  await ref.read(counseleeProvider.notifier).fetchCounselees(next: false);
  }

  @override
  Widget build(BuildContext context) {
    final counseleeState = ref.watch(counseleeProvider);
     screenType = ref.watch(screenTypeProvider);
    var theme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(height: 50,),
        Center(child: Text(screenType.toString(),style: theme.headlineMedium!.copyWith(fontSize: 40),)),
       const SizedBox(height: 30,),

        if (counseleeState.isLoading)
          const Center(child: CircularProgressIndicator(color: kDarkBlue,)),
          if(counseleeState.errorMessage.isNotEmpty)
             Text(counseleeState.errorMessage, style:const TextStyle(color: kRedColor) ,),
        const SizedBox(height: 30,),
        Expanded(
          child: ListView.builder(
            itemCount: counseleeState.counselees.length,
            itemBuilder: (context, index) {
              final counselee = counseleeState.counselees[index];
              return  Card(
                elevation: 4.0,
                color: kWhiteColor,
                child:Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    RichText(
                      text: TextSpan(
                        text: 'Full Name: ',
                        style: theme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                              text: counselee.name,
                            style: theme.bodySmall!.copyWith(fontWeight: FontWeight.bold,color: kBlackColor),
                            ),
                        ],
                  )
                                ),
                     const SizedBox(height: 20,),

                      RichText(
                          text: TextSpan(
                            text: 'Email: ',
                            style: theme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                  text: counselee.email,
                                style: theme.bodySmall!.copyWith(fontWeight: FontWeight.bold,color: kBlackColor),
                              ),
                            ],
                          )
                      ),
                      const SizedBox(height: 20,),

                      RichText(
                          text: TextSpan(
                            text: 'Location ',
                            style: theme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "${counselee.city} ${counselee.state}",
                                style: theme.bodySmall!.copyWith(fontWeight: FontWeight.bold,color: kBlackColor),
                              ),
                            ],
                          )
                      ),
                      const SizedBox(height: 20,),

                      RichText(
                          text: TextSpan(
                            text: 'Date & Time to speak with Counselee: ',
                            style: theme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "${DateFormat("EEEE, d, yyyy").format(DateTime.parse(counselee.selectedDate!))}  Time: ${counselee.selectedTime!}",
                                style: theme.bodySmall!.copyWith(fontWeight: FontWeight.bold,color: kBlackColor),
                              ),
                            ],
                          )
                      ),
                      const SizedBox(height: 20,),

                      RichText(
                          text: TextSpan(
                            text: 'Phone Number: ',
                            style: theme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                  text: counselee.phoneNumber,
                                style: theme.bodySmall!.copyWith(fontWeight: FontWeight.bold,color: kBlackColor),
                              ),
                            ],
                          )
                      ),
                      const SizedBox(height: 20,),

                      RichText(
                          text: TextSpan(
                            text: 'Sex: ',
                            style: theme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                  text: counselee.sex,
                                style: theme.bodySmall!.copyWith(fontWeight: FontWeight.bold,color: kBlackColor),
                              ),
                            ],
                          )
                      ),
                      const SizedBox(height: 20,),

                      RichText(
                          text: TextSpan(
                            text: 'Message: ',
                            style: theme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                  text: counselee.message,
                                style: theme.bodySmall!.copyWith(fontWeight: FontWeight.bold,color: kBlackColor),
                              ),
                            ],
                          )
                      ),
                      const SizedBox(height: 20,),

                      RichText(
                          text: TextSpan(
                            text: 'Replied message: ',
                            style: theme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                  text: counselee.reply,
                                style: theme.bodySmall!.copyWith(fontWeight: FontWeight.bold,color: kBlackColor),
                              ),
                            ],
                          )
                      ),
                      const SizedBox(height: 20,),

                      RichText(
                          text: TextSpan(
                            text: 'Date time: ',
                            style: theme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                text: counselee.datetime,
                                style: theme.bodySmall!.copyWith(fontWeight: FontWeight.bold,color: kBlackColor),
                              ),
                            ],
                          )
                      ),
                      const SizedBox(height: 20,),
                       const Divider(),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                              text: TextSpan(
                                text: 'Responded: ',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: counselee.replied, style: theme.titleSmall!.copyWith(
                                      color: counselee.replied == "No"?kRedColor:kGreenColor
                                  )),
                                ],
                              )
                          ),

                          GestureDetector(
                            onTap:(){
                              ref.read(counseleeProvider.notifier).updateSeenCounselee(counselee,counseleeState.counselees);
                            },
                            child: RichText(
                                text: TextSpan(
                                  text: 'Seen: ',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: counselee.seen, style: theme.titleSmall!.copyWith(
                                        color: counselee.seen == "No"?kRedColor:kGreenColor
                                    )),
                                  ],
                                )
                            ),
                          ),

                          GestureDetector(
                              onTap:(){
                                _editReply(counselee, counseleeState.counselees);
                               },
                              child: Text("Reply Counselee", style: theme.titleSmall!.copyWith(color: kBlueColor),)),

                          GestureDetector(
                              onTap:(){
                                ref.read(counseleeProvider.notifier).deleteCounselee(counselee,counseleeState.counselees);
                              },
                              child: Text("Delete Counselee", style: theme.titleSmall!.copyWith(color: kRedColor),))
                        ],
                      ),


                      const SizedBox(height: 50,),
                                ]
                                ),
                ));
            },
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GeneralButton(title: "Previous", tapStudiesButton: (){
              ref.read(counseleeProvider.notifier).executeFunction(screenType, next: false);
            }),

            GeneralButton(title: "Next", tapStudiesButton: (){
              ref.read(counseleeProvider.notifier).executeFunction(screenType, next: true);
            })

          ],
        ),
       const SizedBox(height: 20,)
      ],
    );
  }
}

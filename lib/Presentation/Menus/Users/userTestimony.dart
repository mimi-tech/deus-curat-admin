import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/dimens.dart';
import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/needyModel.dart';
import 'package:deuscurat_admin/Models/testimonyModel.dart';
import 'package:deuscurat_admin/Models/userModel.dart';
import 'package:deuscurat_admin/Presentation/Commons/imageDisplay.dart';
import 'package:deuscurat_admin/Presentation/Menus/emptyMenu.dart';
import 'package:deuscurat_admin/Presentation/Request/widgets/editNeedyDetails.dart';
import 'package:deuscurat_admin/Presentation/Request/widgets/requestWidget.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/progressIndicator.dart';
import 'package:deuscurat_admin/Utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
class UserTestimony extends ConsumerWidget {
  const UserTestimony({Key? key,this.user}) : super(key: key);
  final NewUser? user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double widthSize = width * 0.1;
    double heightSize = height * 0.2;
    var theme = Theme.of(context).textTheme;
    final myChangeNotifier = ref.watch(myChangeNotifierProvider);
    return user!.requestCount >= 1 ?FutureBuilder<TestimonyModel>(
        future: myChangeNotifier.getUserTestimony(user!.userId), // The future to wait for
        builder: (BuildContext context, AsyncSnapshot<TestimonyModel> snapshot) {
          if(snapshot.hasData){
            TestimonyModel? users = snapshot.data;
            return users!.firstName == null ?Text(""):Container(
              color: kWhiteColor,
              width: width,
              margin: EdgeInsets.symmetric(horizontal: kMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(),
                  Center(child: Text("${users.firstName} ${users.lastName} Testimony",style: Theme.of(context).textTheme.titleMedium,)),
                   spacing(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageDisplay(
                            height:Responsive.isMobile(context)?height * 0.1: heightSize,
                            width: Responsive.isDesktop(context)?widthSize:width * 0.7,
                            imageUrl:users.imagesBefore.toString() ,
                          ),

                          Stack(
                            //alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                color: kBlackColor,
                                width: widthSize,
                                height: heightSize,),
                              const Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                top: 5,
                                child: Center(
                                  child: InkWell(
                                    child:Icon(Icons.play_arrow,color: kWhiteColor,),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageDisplay(
                            height:Responsive.isMobile(context)?height * 0.1: heightSize,
                            width: Responsive.isDesktop(context)?widthSize:width * 0.7,
                            imageUrl:users.imagesAfter.toString() ,
                          ),

                          Stack(
                            //alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                color: kBlackColor,
                                width: widthSize,
                                height: heightSize,),
                              const Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                top: 5,
                                child: Center(
                                  child: InkWell(
                                    child:Icon(Icons.play_arrow,color: kWhiteColor,),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  spacing(),



                  spacing(),
                  Text(users.testimonyTitle.toString(),style: theme.displayMedium),
                  spacing(),
                  ReadMoreText(users.testimonyDesc.toString(),
                    trimLines: 2,
                    style:theme.headlineMedium,
                    colorClickableText: kOrangeColor,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Show less',
                    lessStyle:  TextStyle(fontSize: kFontSize12,color: kOrangeColor),
                    moreStyle: TextStyle(fontSize:kFontSize12 ,color: kOrangeColor),
                  ),
                  spacing(),

                ],
              ),
            );
          }
          if(snapshot.hasError){
            return const EmptyMenu();
          }
          return const Center(child: CircularProgressIndicator());
        }

    ): Text("");

  }


}

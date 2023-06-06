import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/supportModel.dart';
import 'package:deuscurat_admin/Models/userModel.dart';
import 'package:deuscurat_admin/Presentation/Menus/Admin/createAdmin.dart';
import 'package:deuscurat_admin/Presentation/Menus/Mail/composeDialog.dart';
import 'package:deuscurat_admin/Presentation/Menus/Mail/mailWidget.dart';
import 'package:deuscurat_admin/Presentation/Menus/Users/usersWidget.dart';
import 'package:deuscurat_admin/Presentation/Menus/emptyMenu.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:deuscurat_admin/Utils/pagination.dart';
import 'package:deuscurat_admin/Utils/progressIndicator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class AllMails extends ConsumerStatefulWidget {
  const AllMails({Key? key}) : super(key: key);

  @override
  _AllMailsState createState() => _AllMailsState();
}

class _AllMailsState extends ConsumerState<AllMails> {

  Future<List <SupportModel>> ?  supportList;
  int count = 0;
  String type = 'admin';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    supportList = ref.read(myChangeNotifierProvider).getSupport();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement initState
    super.didChangeDependencies();
    supportList = ref.read(myChangeNotifierProvider).getSupport();
  }


  Widget _needyList(){
    return FutureBuilder(
        future: supportList,
        builder: (BuildContext context, AsyncSnapshot<List<SupportModel>> snapshot){
          if(snapshot.hasData){
            count = snapshot.data!.length;

            if(count == 0){

              return Center(child: Text("No User found".toString().toUpperCase(),style: Theme.of(context).textTheme.bodyLarge,));
            }

            return AllMailsWidget(support : snapshot.data);
          }
          if(snapshot.hasError){
            return const EmptyMenu();
          }
          return const Center(child: CircularProgressIndicator());
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final myChangeNotifier = ref.watch(myChangeNotifierProvider);
    final screenType = ref.watch(screenTypeProvider);
    supportList = ref.read(myChangeNotifierProvider).getSupport();

    return Column(
      children: [
        spacing(),
        Text(screenType.toString().toUpperCase(),style: theme.bodyLarge,),
        myChangeNotifier.loading == true?const ShowProgressIndicator(): Align(
            alignment: Alignment.topRight,
            child: GeneralButton(title: "Compose", tapStudiesButton: (){ComposeDialog().showComposeDialog(context);})),
        spacing(),

        Expanded(
          child: ListView(
            children: [
              _needyList(),
            ],
          ),
        ),
        spacing(),
        PaginationFunction().nextDocument(documentLength: count,pageNumber: myChangeNotifier.pageNumber,
            loadNextDocument:(){

              ref.read(myChangeNotifierProvider).incrementPageNumber();
              supportList = ref.read(myChangeNotifierProvider).getSupport();

            },
            loadPrevDocument: (){

              ref.read(myChangeNotifierProvider).decrementPageNumber();
              supportList = ref.read(myChangeNotifierProvider).getSupport();
            }
        ),
        spacing(),
      ],
    );
  }
}



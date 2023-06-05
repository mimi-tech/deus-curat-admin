import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/userModel.dart';
import 'package:deuscurat_admin/Presentation/Menus/Admin/adminWidget.dart';
import 'package:deuscurat_admin/Presentation/Menus/Admin/createAdmin.dart';
import 'package:deuscurat_admin/Presentation/Menus/Users/usersWidget.dart';
import 'package:deuscurat_admin/Presentation/Menus/emptyMenu.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:deuscurat_admin/Utils/pagination.dart';
import 'package:deuscurat_admin/Utils/progressIndicator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class AllAdmins extends ConsumerStatefulWidget {
  const AllAdmins({Key? key}) : super(key: key);

  @override
  _AllAdminsState createState() => _AllAdminsState();
}

class _AllAdminsState extends ConsumerState<AllAdmins> {

  Future<List <NewUser>> ?  usersList;
  int count = 0;
  String type = 'admin';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usersList = ref.read(myChangeNotifierProvider).getUsers(type);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement initState
    super.didChangeDependencies();
    usersList = ref.read(myChangeNotifierProvider).getUsers(type);
  }


  Widget _needyList(){
    return FutureBuilder(
        future: usersList,
        builder: (BuildContext context, AsyncSnapshot<List<NewUser>> snapshot){
          if(snapshot.hasData){
            count = snapshot.data!.length;

            if(count == 0){

              return Center(child: Text("No User found".toString().toUpperCase(),style: Theme.of(context).textTheme.bodyLarge,));
            }

            return AdminWidget(adminUsers : snapshot.data);
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


    usersList = ref.read(myChangeNotifierProvider).getUsers(type);

    return Column(
      children: [
        spacing(),
        Text(screenType.toString().toUpperCase(),style: theme.bodyLarge,),
       myChangeNotifier.loading == true?const ShowProgressIndicator(): Align(
            alignment: Alignment.topRight,
            child: GeneralButton(title: "Create Admin", tapStudiesButton: (){CreateAdminDialog().showCreateAdminDialog(context);})),
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
              usersList = ref.read(myChangeNotifierProvider).getUsers(type);

            },
            loadPrevDocument: (){

              ref.read(myChangeNotifierProvider).decrementPageNumber();
              usersList = ref.read(myChangeNotifierProvider).getUsers(type);
            }
        ),
        spacing(),
      ],
    );
  }
}



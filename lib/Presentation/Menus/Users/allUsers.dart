import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/payment.dart';
import 'package:deuscurat_admin/Models/userModel.dart';
import 'package:deuscurat_admin/Presentation/Menus/Donation/Widget/donationWidget.dart';
import 'package:deuscurat_admin/Presentation/Menus/Users/usersWidget.dart';
import 'package:deuscurat_admin/Presentation/Menus/emptyMenu.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/generalButton.dart';
import 'package:deuscurat_admin/Utils/pagination.dart';
import 'package:deuscurat_admin/Utils/validation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
class AllUsers extends ConsumerStatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends ConsumerState<AllUsers> {
  final TextEditingController _searchText = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? searchText;
  Future<List <NewUser>> ?  usersList;
  int count = 0;
  String type = "all";

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
    getType();
    usersList = ref.read(myChangeNotifierProvider).getUsers(type);
  }

  getType(){
    final screenType = ref.watch(screenTypeProvider);
    switch (screenType) {
      case users:

        type = 'all';
        break;
      case blockedUsers:
        type = 'blocked';
        break;
      default:
        print('Selected fruit is unknown');
    }
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

            return UsersWidget(users : snapshot.data);
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

    getType();
    usersList = ref.read(myChangeNotifierProvider).getUsers(type);

    return Column(
      children: [
        spacing(),


        Text(screenType.toString().toUpperCase(),style: theme.bodyLarge,),
        spacing(),

        Row(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child:TextFormField(
                  controller: _searchText,
                  cursorColor: (kOrangeColor),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  style: Theme.of(context).textTheme.bodyMedium,
                  validator: Validator.validateFieldSearch,
                  decoration:  InputDecoration(
                    hintText: "Search by username, email or firstname",
                     prefixIcon: const Icon(Icons.search,color: kRadioColor,),
                     suffix:  GeneralButton(title: "Search", tapStudiesButton: (){
                       final form = _formKey.currentState;

                       if (form!.validate()) {
                         form.save();
                         FocusScopeNode currentFocus = FocusScope.of(context);

                         if (!currentFocus.hasPrimaryFocus) {
                           currentFocus.unfocus();
                         }
                         ref.read(screenTypeProvider.notifier).state = searchUsers;
                         myChangeNotifier.getSearchUser(_searchText.text.trim());
                       }
                     }),
                  ),
                  onSaved: (String? value) {
                    searchText = value!;
                  },
                ),
              ),
            ),


          ],
        ),
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
              getType();
              ref.read(myChangeNotifierProvider).incrementPageNumber();
              usersList = ref.read(myChangeNotifierProvider).getUsers(type);

            },
            loadPrevDocument: (){
              getType();
              ref.read(myChangeNotifierProvider).decrementPageNumber();
              usersList = ref.read(myChangeNotifierProvider).getUsers(type);
            }
        ),
        spacing(),
      ],
    );
  }
}



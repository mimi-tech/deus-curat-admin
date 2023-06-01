import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/appNotifier.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/needyModel.dart';
import 'package:deuscurat_admin/Presentation/Menus/emptyMenu.dart';
import 'package:deuscurat_admin/Presentation/Request/widgets/requestWidget.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/pagination.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
class NewRequest extends ConsumerStatefulWidget {
  const NewRequest({Key? key}) : super(key: key);

  @override
  _NewRequestState createState() => _NewRequestState();
}

class _NewRequestState extends ConsumerState<NewRequest> {

  Future<List <NeedyModel>> ?  needyList;
  int count = 0;
  String type = "all";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    needyList = ref.read(myChangeNotifierProvider).getRequest(type);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement initState
    super.didChangeDependencies();
    getType();
    needyList = ref.read(myChangeNotifierProvider).getRequest(type);
  }

  getType(){
    final screenType = ref.watch(screenTypeProvider);
    switch (screenType) {
      case allRequest:
        type = 'all';
        break;
      case newRequest:
        type = 'new';
        break;
      case rejectedRequest:
        type = 'rejected';
        break;
      case displayedRequest:
        type = 'display';
        break;
      case shownRequest:
        type = 'showed';
        break;
      default:
        print('Selected fruit is unknown');
    }
  }


  Widget _needyList(){
    return FutureBuilder(
        future: needyList,
        builder: (BuildContext context, AsyncSnapshot<List<NeedyModel>> snapshot){
          if(snapshot.hasData){
            count = snapshot.data!.length;
            final screenType = ref.watch(screenTypeProvider);
            if(count == 0){
              return Center(child: Text("No request found".toString().toUpperCase(),style: Theme.of(context).textTheme.bodyLarge,));
            }
            return RequestWidget(needy : snapshot.data);
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
    needyList = ref.read(myChangeNotifierProvider).getRequest(type);
    return Column(
      children: [
        spacing(),
        Text(screenType.toString().toUpperCase(),style: theme.bodyLarge,),
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
              needyList = ref.read(myChangeNotifierProvider).getRequest(type);

            },
            loadPrevDocument: (){
              getType();
              ref.read(myChangeNotifierProvider).decrementPageNumber();
              needyList = ref.read(myChangeNotifierProvider).getRequest(type);
            }
        ),
        spacing(),
      ],
    );
  }
}

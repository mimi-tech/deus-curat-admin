import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/payment.dart';
import 'package:deuscurat_admin/Models/testimonyModel.dart';
import 'package:deuscurat_admin/Presentation/Menus/Donation/Widget/donationWidget.dart';
import 'package:deuscurat_admin/Presentation/Menus/Testimony/testimonyWidget.dart';
import 'package:deuscurat_admin/Presentation/Menus/emptyMenu.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/pagination.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
class Testimony extends ConsumerStatefulWidget {
  const Testimony({Key? key}) : super(key: key);

  @override
  _TestimonyState createState() => _TestimonyState();
}

class _TestimonyState extends ConsumerState<Testimony> {

  Future<List <TestimonyModel>> ?  testimonyList;
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    testimonyList = ref.read(myChangeNotifierProvider).getTestimony();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement initState
    super.didChangeDependencies();

    testimonyList = ref.read(myChangeNotifierProvider).getTestimony();
  }



  Widget _needyList(){
    return FutureBuilder(
        future: testimonyList,
        builder: (BuildContext context, AsyncSnapshot<List<TestimonyModel>> snapshot){
          if(snapshot.hasData){
            count = snapshot.data!.length;

            if(count == 0){

              return Center(child: Text("No Testimony found".toString().toUpperCase(),style: Theme.of(context).textTheme.bodyLarge,));
            }

            return TestimonyWidget(testimony : snapshot.data);
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

    testimonyList = ref.read(myChangeNotifierProvider).getTestimony();

    return Column(
      children: [
        spacing(),
        Text("Peoples Testimonies".toUpperCase(),style: theme.bodyLarge,),
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
              testimonyList = ref.read(myChangeNotifierProvider).getTestimony();

            },
            loadPrevDocument: (){

              ref.read(myChangeNotifierProvider).decrementPageNumber();
              testimonyList = ref.read(myChangeNotifierProvider).getTestimony();
            }
        ),
        spacing(),
      ],
    );
  }
}

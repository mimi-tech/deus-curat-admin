import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/payment.dart';
import 'package:deuscurat_admin/Presentation/Menus/Donation/Widget/donationWidget.dart';
import 'package:deuscurat_admin/Presentation/Menus/emptyMenu.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/pagination.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
class Donations extends ConsumerStatefulWidget {
  const Donations({Key? key}) : super(key: key);

  @override
  _DonationsState createState() => _DonationsState();
}

class _DonationsState extends ConsumerState<Donations> {

  Future<List <PaymentModel>> ?  paymentList;
  int count = 0;
  String type = "all";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentList = ref.read(myChangeNotifierProvider).getPaymentType(type);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement initState
    super.didChangeDependencies();
    getType();
    paymentList = ref.read(myChangeNotifierProvider).getPaymentType(type);
  }

  getType(){
    final screenType = ref.watch(screenTypeProvider);
    switch (screenType) {
      case allDonation:

        type = 'all';
        break;
      case acceptedDonation:

        type = 'accept';
        break;
      case newDonation:

        type = 'new';
        break;
      default:
        print('Selected fruit is unknown');
    }
  }


  Widget _needyList(){
    return FutureBuilder(
        future: paymentList,
        builder: (BuildContext context, AsyncSnapshot<List<PaymentModel>> snapshot){
          if(snapshot.hasData){
            count = snapshot.data!.length;

            if(count == 0){

              return Center(child: Text("No Donation found".toString().toUpperCase(),style: Theme.of(context).textTheme.bodyLarge,));
            }

            return DonationWidget(donation : snapshot.data);
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
    paymentList = ref.read(myChangeNotifierProvider).getPaymentType(type);
    print("444444");
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
              paymentList = ref.read(myChangeNotifierProvider).getPaymentType(type);

            },
            loadPrevDocument: (){
              getType();
              ref.read(myChangeNotifierProvider).decrementPageNumber();
              paymentList = ref.read(myChangeNotifierProvider).getPaymentType(type);
            }
        ),
        spacing(),
      ],
    );
  }
}

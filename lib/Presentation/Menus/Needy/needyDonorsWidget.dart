import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Logic/appNotifier.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/needyModel.dart';
import 'package:deuscurat_admin/Models/payment.dart';
import 'package:deuscurat_admin/Presentation/Menus/Dashboard/highestDonors.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
class NeedyDonors extends ConsumerWidget {
  const NeedyDonors({Key? key, required this.needyDetails, this.requestIndex}) : super(key: key);
  final List<NeedyModel>? needyDetails;
  final int? requestIndex;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var theme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final myChangeNotifier = ref.watch(myChangeNotifierProvider);
    return myChangeNotifier.requestPayments.isEmpty?const Center(child: Text("There is no payment found for the above request(s)")):Column(
     // mainAxisSize: MainAxisSize.min,
      children: [

        Expanded(
          child: ListView(
            children: [
              ListView.builder(
                  itemCount: needyDetails!.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
              itemBuilder: ( context, index){
               return  SizedBox(
                width: width * 0.5,

                child: PaginatedDataTable(
                  header:  Text("${needyDetails![index].firstName} ${needyDetails![index].lastName} Donors",style: theme.displayMedium,
                  ),
                  rowsPerPage: myChangeNotifier.requestPayments[requestIndex??index].length == 0 ? 1:myChangeNotifier.requestPayments[requestIndex??index].length,
                  columnSpacing:width * 0.04 ,
                  arrowHeadColor: kYellow,
                  columns:  [
                    DataColumn(label: Text('S / N',style: theme.displayMedium,)),
                    DataColumn(label: Text('First name',style: theme.displayMedium,)),
                    DataColumn(label: Text('Last name',style: theme.displayMedium,)),
                    DataColumn(label: Text('Gender',style: theme.displayMedium,)),
                    DataColumn(label: Text('Amount',style: theme.displayMedium,)),
                    DataColumn(label: Text('Date & Time',style: theme.displayMedium,)),
                  ],
                  source: DataSources(context, myChangeNotifier.requestPayments[requestIndex??index]),
                ),
              );
  }),
            ],
          ),
        ),
        spacing(),
      ],
    );}
}

class _Row {
  _Row(
      this.valueA,
      this.valueB,
      this.valueC,
      this.valueD,
      this.valueE,
      this.valueF,
      );

  final String valueA;
  final String valueB;
  final String valueC;
  final String valueD;
  final String valueE;
  final String valueF;

  bool selected = false;
}

class DataSources extends DataTableSource {
  DataSources(this.context, this.donors) {
    _rows = <_Row>[];

    for(int i = 0; i < donors!.length; i++){
      _rows!.add(_Row("${i + 1}", "${donors![i]['senderDetails']['firstName']}","${donors![i]['senderDetails']['lastName']}","${donors![i]['senderDetails']['gender']}","${donors![i]['amount']}","${donors![i]['createdAt']}")
      );
    }

  }

  final BuildContext context;
  List<_Row>? _rows;
  final List<dynamic>? donors;

  int _selectedCount = 0;
  @override
  DataRow? getRow(int index) {
    var theme = Theme.of(context).textTheme;
    assert(index >= 0);
    if (index >= _rows!.length) return null;
    final row = _rows![index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (bool? value) {
        if (row.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.valueA,style: theme.displayLarge,)),
        DataCell(Text(row.valueB,style: theme.displayLarge,)),
        DataCell(Text(row.valueC,style: theme.displayLarge,)),
        DataCell(Text(row.valueD.toString(),style: theme.displayLarge!.copyWith(color:row.valueD == "female"?kDoneColor:kGreenColor),)),
        DataCell(Text(row.valueE.toString(),style: theme.displayLarge!.copyWith(color: kOrangeColor),)),
        DataCell(Text(DateFormat("EEEE, dd,MMM, yyyy h:ma").format(DateTime.parse(row.valueF)),style: theme.displayLarge,)),
      ],
    );
  }

  @override
  int get rowCount => _rows!.length;

  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => _selectedCount;
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}




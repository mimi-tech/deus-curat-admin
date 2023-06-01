import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Models/payment.dart';
import 'package:deuscurat_admin/Presentation/Menus/Dashboard/dashboard.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/currency%20Format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HighestDonors extends StatelessWidget {
   const HighestDonors({Key? key,required this.donors, required this.testimonyCount,required this.requestCount}) : super(key: key);
    final List<PaymentModel> ? donors;
    final dynamic testimonyCount;
    final dynamic requestCount;

  @override
  Widget build(BuildContext context) {
    List<double> amount = [];

    for(int i = 0; i < donors!.length; i++){
      amount.add(donors![i].amount);
    }
    var theme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: width * 0.03,
          runSpacing: height * 0.01,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: width * 0.5,
              child: PaginatedDataTable(
                header:  Text('Highest Donors',style: theme.displayMedium,),
                rowsPerPage: donors!.length,
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
                source: DataSource(context, donors),
              ),
            ),

            SizedBox(
              height: height * 0.3,
              width: width * 0.17,
        child: Container(color: kOrangeColor,),
        //       child: SfCartesianChart(
        //         backgroundColor: kGreenColor,
        //         borderColor: Colors.purpleAccent,
        //         plotAreaBackgroundColor: Colors.pinkAccent,
        //         plotAreaBorderColor: Colors.white,
        //         primaryXAxis: CategoryAxis(),
        //         title: ChartTitle(text: 'Highest Donors'),
        //         tooltipBehavior: TooltipBehavior(enable: true),
        //         series: <ChartSeries>[
        //           LineSeries<double, String>(
        //             dataSource: amount,
        //             xValueMapper: (value, _) => amount.indexOf(value).toString(),
        //             yValueMapper: (value, _) => value,
        //             name: "Donors",
        //             dataLabelSettings: DataLabelSettings(isVisible: true)
        //
        // ),
        //         ],
        //       ),
              ),


          ],
        ),
       spacing(),
        Wrap(
          spacing: width * 0.03,
          runSpacing: height * 0.01,
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [

            CardWidget(title:"Testimony Count",amount:testimonyCount,onTap: (){},),
            CardWidget(title:"Request Count",amount:requestCount,onTap: (){},),
            CardWidget(title:"No Of Users",amount:requestCount,onTap: (){},)

          ],
        ),
        spacing(),
      ],
    );
  }
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

class DataSource extends DataTableSource {
  DataSource(this.context, this.donors) {
    _rows = <_Row>[];

    for(int i = 0; i < donors!.length; i++){
      _rows!.add(_Row("${i + 1}", "${donors![i].firstName}","${donors![i].lastName}","${donors![i].gender}","${donors![i].amount}","${donors![i].createdAt}")
      );
    }

  }

  final BuildContext context;
  List<_Row>? _rows;
  final List<PaymentModel>? donors;

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


class CardWidget extends StatelessWidget {
  const CardWidget({Key? key,

    this.onTap,
    this.title,
    this.amount
  }) : super(key: key);
  final VoidCallback? onTap;
  final String? title;
  final dynamic amount;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var theme = Theme.of(context).textTheme;
    return  SizedBox(
      width: width * 0.2,
      child: Card(
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacing(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title!,style: theme.displayLarge,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(amount.toString(),style: theme.bodyLarge,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: OutlinedButton(
                  onPressed: onTap,
                  child: Text("See More",style: Theme.of(context).textTheme.labelLarge!.copyWith(color: kDrawerTextColor),),),
              ),
            ),
            spacing(),
          ],
        ),
      ),
    );
  }
}

import 'package:intl/intl.dart';

formatCurrency(price) {


  String formattedMoney = NumberFormat.currency(
    locale: 'en_US',
    symbol: '',
    decimalDigits: 2,
  ).format(price);

  return "#$formattedMoney";// $1,234.56
}


int currentWeekNumber() {
  final now = DateTime.now();
  final year = int.parse(DateFormat('y').format(now));
  final firstDayOfYear = DateTime(year);
  final daysSinceFirstDayOfYear = now.difference(firstDayOfYear).inDays;
  return (daysSinceFirstDayOfYear / 7).ceil();
}


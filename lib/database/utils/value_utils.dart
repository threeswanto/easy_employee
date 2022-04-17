import 'package:intl/intl.dart';

class ValueUtils {
  static String generateID(int lastNumber) {
    NumberFormat formatter = NumberFormat("000");
    String numberID;
    numberID = "IP06" + formatter.format(lastNumber);
    return numberID;

  }

  static String generateDate(String value) {
    DateTime myDate = DateTime.parse(value);
    final date = DateFormat('dd-MMM-yy');
    return date.format(myDate);
  }

  static int generateDaysLeave(String start, String end) {
    DateTime myDateStart = DateTime.parse(start);
    DateTime myDateEnd = DateTime.parse(end);
    return (myDateStart.difference(myDateEnd).inDays*-1) + 1;
  }
}

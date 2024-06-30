import 'package:intl/intl.dart';

extension StringExtension on String {
  String getFormattedDate() {
    DateTime dateTime = DateFormat("yyyy-MM-ddThh:mm:ss").parse(this);
    return DateFormat("hh:mm   dd/MM/yyyy").format(dateTime);
  }
}

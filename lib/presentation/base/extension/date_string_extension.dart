import 'package:intl/intl.dart';

extension StringExtension on String {
  String getFormattedDate() {
    DateTime dateTime = DateFormat("yyyy-MM-ddThh:mm:ss").parse(this);
    return DateFormat("dd-MM-yyy").format(dateTime);
  }
}

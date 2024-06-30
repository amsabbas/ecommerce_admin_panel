import 'package:get/get.dart';

import '../language/language.dart';

extension StringExtension on String? {
  String isAvailable() {
    if (this == "true") {
      return MessageKeys.yes.tr;
    } else {
      return MessageKeys.no.tr;
    }
  }
  String getStatus() {
    if (this == "pending") {
      return MessageKeys.pending.tr;
    } else if (this == "completed") {
      return MessageKeys.completed.tr;
    } else {
      return MessageKeys.cancelled.tr;
    }
  }
}

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
}

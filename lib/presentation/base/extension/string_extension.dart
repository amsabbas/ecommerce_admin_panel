import 'package:ecommerce_admin/presentation/base/model/constants.dart';
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
    if (this == pendingStatus) {
      return MessageKeys.pending.tr;
    } else if (this == acceptedStatus) {
      return MessageKeys.accepted.tr;
    } else {
      return MessageKeys.rejected.tr;
    }
  }
}

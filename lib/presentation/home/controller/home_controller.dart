import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../../data/base/utils/app_logger.dart';
import '../../base/utils/result.dart';

class HomeController extends GetxController {
  final orderAddedState = ResultState();
  final _database = FirebaseDatabase.instance.ref('orders');

  HomeController();

  void listenToNewOrders() async {
    try {
      _database.onChildAdded.listen((DatabaseEvent event) {
        orderAddedState.setSuccess(true);
        _database.remove();
      }, onError: (error, errorStack) {
        AppLogger.error(error: error, errorStack: errorStack);
      });
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
    }
  }

  void reset() {
    orderAddedState.resetState();
  }

  @override
  void dispose() {
    super.dispose();
    orderAddedState.close();
  }
}

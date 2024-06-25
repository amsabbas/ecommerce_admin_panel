import 'package:ecommerce_admin/data/dashboard/interactor/dashboard_interactor.dart';
import 'package:ecommerce_admin/data/orders/interactor/orders_interactor.dart';
import 'package:get/get.dart';

import '../../../data/base/utils/app_logger.dart';
import '../../base/utils/result.dart';

class DashboardController extends GetxController {
  final dataState = ResultState();
  final ordersState = ResultState();
  final dashboardState = ResultState();
  late final DashboardInteractor userInteractor;
  late final OrdersInteractor orderInteractor;

  DashboardController(
      {required this.userInteractor, required this.orderInteractor});

  void getData() async {
    try {
      dashboardState.setLoading();
      dataState.setLoading();
      ordersState.setLoading();

      dataState.setSuccess(await userInteractor.getData());
      ordersState.setSuccess(await orderInteractor.getRecentOrders());

      dashboardState.setSuccess(null);
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
        dataState.setError(error);
        dashboardState.setError(error);
    }
  }

  @override
  void dispose() {
    super.dispose();
    dataState.close();
  }
}

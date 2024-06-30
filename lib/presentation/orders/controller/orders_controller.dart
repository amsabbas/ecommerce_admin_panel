import 'package:async/async.dart';
import 'package:ecommerce_admin/data/base/model/meta_paginated_model.dart';
import 'package:ecommerce_admin/data/orders/interactor/orders_interactor.dart';
import 'package:ecommerce_admin/data/orders/model/order_model.dart';
import 'package:get/get.dart';

import '../../../data/base/utils/app_logger.dart';
import '../../base/utils/result.dart';

class OrdersController extends GetxController {
  final ordersState = ResultState<List<OrderModel>>();
  final metaState = ResultState<MetaPaginatedModel>();

  final int take = 5;
  final List<CancelableOperation> _operations = [];
  late final OrdersInteractor ordersInteractor;

  OrdersController({
    required this.ordersInteractor,
  });

  void getOrders(int page) async {
    if (ordersState.state == CurrentState.loading) {
      return;
    }

    var cancellableOperation = CancelableOperation.fromFuture(
        ordersInteractor.getAllOrdersEndPoint(page, take));

    cancellableOperation.value.then((result) {
      List<OrderModel> orders = result.data;
      MetaPaginatedModel meta = result.meta;
      metaState.setSuccess(meta);
      ordersState.setSuccess(orders);
    }, onError: (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      ordersState.setError(error);
    });

    _operations.add(cancellableOperation);
  }

  void resetOrders() {
    ordersState.resetState();

    for (var operation in _operations) {
      operation.cancel();
    }
    _operations.clear();
  }

  @override
  void dispose() {
    super.dispose();
    ordersState.close();
  }
}

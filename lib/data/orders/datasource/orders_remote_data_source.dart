import 'package:ecommerce_admin/data/base/network/service_generator.dart';
import 'package:ecommerce_admin/data/base/utils/auth_manager.dart';
import 'package:ecommerce_admin/data/orders/datasource/end_points/orders_endpoints.dart';
import 'package:ecommerce_admin/data/orders/model/order_model.dart';

class OrdersRemoteDataSource {
  final ServiceGenerator service;
  final AuthManager authManager;

  OrdersRemoteDataSource({required this.service, required this.authManager});

  Future<List<OrderModel>> getRecentOrders() async {
    return service
        .call(OrdersEndPoints.getRecentOrdersEndPoint())
        .then((response) => response
            .map<OrderModel>((e) => OrderModel.fromJson(e))
            .toList());
  }
}

import 'package:ecommerce_admin/data/base/network/service_generator.dart';
import 'package:ecommerce_admin/data/base/utils/auth_manager.dart';
import 'package:ecommerce_admin/data/orders/datasource/end_points/orders_endpoints.dart';
import 'package:ecommerce_admin/data/orders/model/order_model.dart';
import 'package:ecommerce_admin/data/orders/model/order_response_model.dart';

class OrdersRemoteDataSource {
  final ServiceGenerator service;
  final AuthManager authManager;

  OrdersRemoteDataSource({required this.service, required this.authManager});

  Future<List<OrderModel>> getRecentOrders() async {
    final userToken = authManager.getToken();
    return service
        .call(OrdersEndPoints.getRecentOrdersEndPoint(userToken: userToken))
        .then((response) =>
            response.map<OrderModel>((e) => OrderModel.fromJson(e)).toList());
  }

  Future<OrderResponseModel> getAllOrdersEndPoint(int page, int take) async {
    Map<String, dynamic> map = {'page': page, 'take': take, 'order': 'DESC'};
    final userToken = authManager.getToken();
    return service
        .call(OrdersEndPoints.getAllOrdersEndPoint(
            userToken: userToken, data: map))
        .then((response) => OrderResponseModel.fromJson(response));
  }
}

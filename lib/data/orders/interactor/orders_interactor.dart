import 'package:ecommerce_admin/data/orders/model/order_model.dart';
import 'package:ecommerce_admin/data/orders/model/order_response_model.dart';
import 'package:ecommerce_admin/data/orders/repository/orders_repository_impl.dart';

class OrdersInteractor {
  final OrdersRepository repository;

  OrdersInteractor({required this.repository});

  Future<List<OrderModel>> getRecentOrders() async =>
      await repository.getRecentOrders();

  Future<OrderResponseModel> getAllOrdersEndPoint(int page, int take) async =>
      await repository.getAllOrdersEndPoint(page, take);

  Future changeOrderStatusEndPoint(int orderID, String status) async =>
      await repository.changeOrderStatusEndPoint(orderID, status);
}

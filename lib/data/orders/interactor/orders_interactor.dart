import 'package:ecommerce_admin/data/orders/model/order_model.dart';
import 'package:ecommerce_admin/data/orders/repository/orders_repository_impl.dart';

class OrdersInteractor {
  final OrdersRepository repository;

  OrdersInteractor({required this.repository});

  Future<List<OrderModel>> getRecentOrders() async =>
      await repository.getRecentOrders();
}

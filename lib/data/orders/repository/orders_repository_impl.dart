import 'package:ecommerce_admin/data/orders/datasource/orders_remote_data_source.dart';
import 'package:ecommerce_admin/data/orders/model/order_model.dart';
import 'package:ecommerce_admin/data/orders/model/order_response_model.dart';

class OrdersRepository {
  final OrdersRemoteDataSource remoteDataSource;

  OrdersRepository({required this.remoteDataSource});

  Future<List<OrderModel>> getRecentOrders() async {
    return await remoteDataSource.getRecentOrders();
  }

  Future<OrderResponseModel> getAllOrdersEndPoint(int page, int take) async {
    return await remoteDataSource.getAllOrdersEndPoint(page, take);
  }
}

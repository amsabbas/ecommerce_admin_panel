import 'package:ecommerce_admin/data/base/utils/end_point.dart';

class OrdersEndPoints {

  static EndPoint getRecentOrdersEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    required String? userToken,
  }) {
    return EndPoint(
        endpoint: "orders/getRecentOrders",
        headers: headers,
        data: data,
        userToken:userToken,
        method: HttpMethod.get);
  }
}

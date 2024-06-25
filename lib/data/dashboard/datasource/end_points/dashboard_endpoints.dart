import 'package:ecommerce_admin/data/base/utils/end_point.dart';

class DashboardEndPoints {

  static EndPoint dashboardDataEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    required String? userToken,
  }) {
    return EndPoint(
        endpoint: "dashboard/getData",
        headers: headers,
        data: data,
        userToken:userToken,
        method: HttpMethod.get);
  }
}

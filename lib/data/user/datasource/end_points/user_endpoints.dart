import 'package:ecommerce_admin/data/base/utils/end_point.dart';

class UserEndPoints {

  static EndPoint loginEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) {
    return EndPoint(
        endpoint: "auth/login",
        headers: headers,
        data: data,
        method: HttpMethod.post);
  }


}

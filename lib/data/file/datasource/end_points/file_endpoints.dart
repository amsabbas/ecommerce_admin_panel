import 'package:ecommerce_admin/data/base/utils/end_point.dart';

class FileEndPoints {

  static EndPoint uploadEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    required String? userToken,
  }) {
    return EndPoint(
        endpoint: "file/upload",
        headers: headers,
        data: data,
        type: HttpType.formData,
        userToken: userToken,
        method: HttpMethod.post);
  }
}

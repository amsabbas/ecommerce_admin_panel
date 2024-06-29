import 'package:ecommerce_admin/data/base/utils/end_point.dart';

class AreasEndPoints {
  static EndPoint getAllEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    required String? userToken,
  }) {
    return EndPoint(
        endpoint: "addresses/getAreas",
        headers: headers,
        data: data,
        userToken:userToken,
        method: HttpMethod.get);
  }

  static EndPoint addEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    required String? userToken,
  }) {
    return EndPoint(
        endpoint: "addresses/createArea",
        headers: headers,
        data: data,
        userToken: userToken,
        method: HttpMethod.post);
  }

  static EndPoint deleteEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    required int id,
    required String? userToken,
  }) {
    return EndPoint(
        endpoint: "addresses/area/$id",
        headers: headers,
        data: data,
        userToken: userToken,
        method: HttpMethod.delete);
  }
}

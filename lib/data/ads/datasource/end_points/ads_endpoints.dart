import 'package:ecommerce_admin/data/base/utils/end_point.dart';

class AdsEndPoints {
  static EndPoint getAllEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) {
    return EndPoint(
        endpoint: "ads/getAllAds",
        headers: headers,
        data: data,
        method: HttpMethod.get);
  }

  static EndPoint addEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    required String? userToken,
  }) {
    return EndPoint(
        endpoint: "ads/createAd",
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
        endpoint: "ads/$id",
        headers: headers,
        data: data,
        userToken: userToken,
        method: HttpMethod.delete);
  }
}

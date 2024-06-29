import 'package:ecommerce_admin/data/base/utils/end_point.dart';

class ProductsEndPoints {

  static EndPoint getAllProductsEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) {
    return EndPoint(
        endpoint: "products/getAllProducts",
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
        endpoint: "products/createProduct",
        headers: headers,
        data: data,
        userToken: userToken,
        method: HttpMethod.post);
  }

  static EndPoint editEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    required String? userToken,
  }) {
    return EndPoint(
        endpoint: "products/editProduct",
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
        endpoint: "products/$id",
        headers: headers,
        data: data,
        userToken: userToken,
        method: HttpMethod.delete);
  }
}

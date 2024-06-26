import 'package:ecommerce_admin/data/base/utils/end_point.dart';

class CategoriesEndPoints {
  static EndPoint getAllCategoriesEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) {
    return EndPoint(
        endpoint: "categories/getAllCategories",
        headers: headers,
        data: data,
        method: HttpMethod.get);
  }

  static EndPoint addCategoryEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    required String? userToken,
  }) {
    return EndPoint(
        endpoint: "categories/createCategory",
        headers: headers,
        data: data,
        userToken: userToken,
        method: HttpMethod.post);
  }

  static EndPoint deleteCategoryEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    required int id,
    required String? userToken,
  }) {
    return EndPoint(
        endpoint: "categories/$id",
        headers: headers,
        data: data,
        userToken: userToken,
        method: HttpMethod.delete);
  }
}

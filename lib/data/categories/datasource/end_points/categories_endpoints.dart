import 'package:ecommerce_admin/data/base/utils/end_point.dart';

class CategoriesEndPoints {

  static EndPoint getAllCategoriesEndPoint({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
  }) {
    return EndPoint(
        endpoint: "categories/categories",
        headers: headers,
        data: data,
        method: HttpMethod.get);
  }
}

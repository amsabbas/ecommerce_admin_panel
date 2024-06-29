import 'package:ecommerce_admin/data/base/network/service_generator.dart';
import 'package:ecommerce_admin/data/base/utils/auth_manager.dart';
import 'package:ecommerce_admin/data/products/datasource/end_points/products_endpoints.dart';
import 'package:ecommerce_admin/data/products/model/product_model.dart';

class ProductsRemoteDataSource {
  final ServiceGenerator service;
  final AuthManager authManager;

  ProductsRemoteDataSource({required this.service, required this.authManager});

  Future<List<ProductModel>> getAllProductsEndPoint() async {
    return service.call(ProductsEndPoints.getAllProductsEndPoint()).then(
        (response) => response
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList());
  }

  Future addProduct(ProductModel model) async {
    Map<String, dynamic> map = {
      'id': model.id,
      'name': model.name,
      'description': model.description,
      'price': model.price,
      'quantity': model.quantity,
      'photo_url': model.photoUrl,
      'is_available': model.isAvailable,
      'category_id': model.categoryId,
    };
    final userToken = authManager.getToken();
    return service
        .call(ProductsEndPoints.addEndPoint(userToken: userToken, data: map));
  }

  Future editProduct(ProductModel model) async {
    Map<String, dynamic> map = {
      'id': model.id,
      'name': model.name,
      'description': model.description,
      'price': model.price,
      'quantity': model.quantity,
      'photo_url': model.photoUrl,
      'is_available': model.isAvailable,
    };
    final userToken = authManager.getToken();
    return service
        .call(ProductsEndPoints.editEndPoint(userToken: userToken, data: map));
  }

  Future deleteProduct(int id) async {
    final userToken = authManager.getToken();
    return service
        .call(ProductsEndPoints.deleteEndPoint(id: id, userToken: userToken));
  }
}

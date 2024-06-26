import 'package:ecommerce_admin/data/base/network/service_generator.dart';
import 'package:ecommerce_admin/data/base/utils/auth_manager.dart';
import 'package:ecommerce_admin/data/categories/datasource/end_points/categories_endpoints.dart';
import 'package:ecommerce_admin/data/categories/model/category_model.dart';

class CategoriesRemoteDataSource {
  final ServiceGenerator service;
  final AuthManager authManager;

  CategoriesRemoteDataSource(
      {required this.service, required this.authManager});

  Future<List<CategoryModel>> getAllCategories() async {
    return service.call(CategoriesEndPoints.getAllCategoriesEndPoint()).then(
        (response) => response
            .map<CategoryModel>((e) => CategoryModel.fromJson(e))
            .toList());
  }

  Future addCategoryEndPoint(String name) async {
    Map<String, String> map = {'name': name};
    final userToken = authManager.getToken();
    return service.call(CategoriesEndPoints.addCategoryEndPoint(
        userToken: userToken, data: map));
  }

  Future deleteCategoryEndPoint(int id) async {
    final userToken = authManager.getToken();
    return service.call(CategoriesEndPoints.deleteCategoryEndPoint(
        id: id, userToken: userToken));
  }
}

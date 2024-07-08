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

  Future addCategory(String name, String nameAr) async {
    Map<String, String> map = {'name': name, 'name_ar': nameAr};
    final userToken = authManager.getToken();
    return service.call(CategoriesEndPoints.addCategoryEndPoint(
        userToken: userToken, data: map));
  }

  Future deleteCategory(int id) async {
    final userToken = authManager.getToken();
    return service.call(CategoriesEndPoints.deleteCategoryEndPoint(
        id: id, userToken: userToken));
  }

  Future editCategory(int id, String name, String nameAr) async {
    Map<String, dynamic> map = {'name': name, 'id': id, 'name_ar': nameAr};
    final userToken = authManager.getToken();
    return service.call(
        CategoriesEndPoints.editEndPoint(userToken: userToken, data: map));
  }
}

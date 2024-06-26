import 'package:ecommerce_admin/data/categories/datasource/categories_remote_data_source.dart';
import 'package:ecommerce_admin/data/categories/model/category_model.dart';

class CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;

  CategoriesRepository({required this.remoteDataSource});

  Future<List<CategoryModel>> getAllCategories() async {
    return await remoteDataSource.getAllCategories();
  }

  Future addCategoryEndPoint(String name) async {
    return await remoteDataSource.addCategoryEndPoint(name);
  }

  Future deleteCategoryEndPoint(int id) async {
    return await remoteDataSource.deleteCategoryEndPoint(id);
  }
}

import 'package:ecommerce_admin/data/categories/model/category_model.dart';
import 'package:ecommerce_admin/data/categories/repository/categories_repository_impl.dart';

class CategoryInteractor {
  final CategoriesRepository repository;

  CategoryInteractor({required this.repository});

  Future<List<CategoryModel>> getAllCategories() async =>
      await repository.getAllCategories();

  Future addCategoryEndPoint(String name) async =>
      await repository.addCategoryEndPoint(name);

  Future deleteCategoryEndPoint(int id) async =>  await repository.deleteCategoryEndPoint(id);
}

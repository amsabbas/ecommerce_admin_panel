import 'package:ecommerce_admin/data/categories/model/category_model.dart';
import 'package:ecommerce_admin/data/categories/repository/categories_repository_impl.dart';

class CategoryInteractor {
  final CategoriesRepository repository;

  CategoryInteractor({required this.repository});

  Future<List<CategoryModel>> getAllCategories() async =>
      await repository.getAllCategories();

  Future addCategory(String name, String nameAr) async =>
      await repository.addCategory(name, nameAr);

  Future deleteCategory(int id) async => await repository.deleteCategory(id);

  Future editCategory(int id, String name, String nameAr) async =>
      await repository.editCategory(id, name, nameAr);
}

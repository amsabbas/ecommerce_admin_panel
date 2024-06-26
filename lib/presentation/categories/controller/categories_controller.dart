import 'package:ecommerce_admin/data/categories/interactor/category_interactor.dart';
import 'package:get/get.dart';

import '../../../data/base/utils/app_logger.dart';
import '../../base/utils/result.dart';

class CategoriesController extends GetxController {
  final categoriesState = ResultState();
  final addCategoryState = ResultState();
  final deleteCategoryState = ResultState();
  late final CategoryInteractor categoriesInteractor;

  CategoriesController({required this.categoriesInteractor});

  void getCategories() async {
    try {
      categoriesState.setLoading();

      categoriesState.setSuccess(await categoriesInteractor.getAllCategories());
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      categoriesState.setError(error);
    }
  }

  void addCategory(String name) async {
    try {
      addCategoryState.setLoading();

      addCategoryState
          .setSuccess(await categoriesInteractor.addCategoryEndPoint(name));
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      addCategoryState.setError(error);
    }
  }

  void deleteCategory(int id) async {
    try {
      deleteCategoryState.setLoading();

      deleteCategoryState
          .setSuccess(await categoriesInteractor.deleteCategoryEndPoint(id));
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      deleteCategoryState.setError(error);
    }
  }

  @override
  void dispose() {
    super.dispose();
    categoriesState.close();
    addCategoryState.close();
    deleteCategoryState.close();
  }
}

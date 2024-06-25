import 'package:ecommerce_admin/data/categories/model/category_model.dart';
import 'package:ecommerce_admin/data/products/interactor/products_interactor.dart';
import 'package:ecommerce_admin/data/products/model/product_model.dart';
import 'package:get/get.dart';

import '../../../data/base/utils/app_logger.dart';
import '../../base/utils/result.dart';

class ProductsController extends GetxController {
  final productsState = ResultState();
  late final ProductsInteractor productsInteractor;

  ProductsController({required this.productsInteractor});

  void getProducts() async {
    try {
      productsState.setLoading();

      productsState
          .setSuccess(await productsInteractor.getAllProductsEndPoint());
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      //  productsState.setError(error);
      productsState.setSuccess([
        ProductModel(
            id: 1,
            name: "name",
            description: "description",
            photoUrl: "photoUrl",
            category: CategoryModel(id: 1, name: "name"),
            quantity: 1,
            isAvailable: true,
            price: 10)
      ]);
    }
  }

  @override
  void dispose() {
    super.dispose();
    productsState.close();
  }
}

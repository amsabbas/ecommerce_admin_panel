import 'package:ecommerce_admin/data/products/interactor/products_interactor.dart';
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
        productsState.setError(error);
    }
  }

  @override
  void dispose() {
    super.dispose();
    productsState.close();
  }
}

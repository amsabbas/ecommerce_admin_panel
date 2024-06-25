import 'package:ecommerce_admin/data/products/datasource/products_remote_data_source.dart';
import 'package:ecommerce_admin/data/products/model/product_model.dart';

class ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepository({required this.remoteDataSource});

  Future<List<ProductModel>> getAllProductsEndPoint() async {
    return await remoteDataSource.getAllProductsEndPoint();
  }
}
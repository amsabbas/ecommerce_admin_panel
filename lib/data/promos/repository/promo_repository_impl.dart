import 'package:ecommerce_admin/data/promos/datasource/promo_remote_data_source.dart';
import 'package:ecommerce_admin/data/promos/model/promo_model.dart';

class PromoRepository {
  final PromoRemoteDataSource remoteDataSource;

  PromoRepository({required this.remoteDataSource});

  Future<List<PromoModel>> getAllPromos() async {
    return await remoteDataSource.getAllPromos();
  }

  Future addPromo(String code, bool isAvailable, double discount) async {
    return await remoteDataSource.addPromo(code, isAvailable, discount);
  }

  Future editPromo(int id, bool isAvailable, double discount) async {
    return await remoteDataSource.editPromo(id, isAvailable, discount);
  }

  Future deletePromo(int id) async {
    return await remoteDataSource.deletePromo(id);
  }

}

import 'package:ecommerce_admin/data/base/network/service_generator.dart';
import 'package:ecommerce_admin/data/base/utils/auth_manager.dart';
import 'package:ecommerce_admin/data/promos/datasource/end_points/pormo_endpoints.dart';
import 'package:ecommerce_admin/data/promos/model/promo_model.dart';

class PromoRemoteDataSource {
  final ServiceGenerator service;
  final AuthManager authManager;

  PromoRemoteDataSource({required this.service, required this.authManager});

  Future<List<PromoModel>> getAllPromos() async {
    final userToken = authManager.getToken();
    return service
        .call(PromoEndPoints.getAllEndPoint(userToken: userToken))
        .then((response) =>
            response.map<PromoModel>((e) => PromoModel.fromJson(e)).toList());
  }

  Future addPromo(String code, bool isAvailable, double discount) async {
    Map<String, dynamic> map = {
      'promo_code': code,
      'is_available': isAvailable,
      'discount_value': discount
    };
    final userToken = authManager.getToken();
    return service
        .call(PromoEndPoints.addEndPoint(userToken: userToken, data: map));
  }

  Future editPromo(int id, bool isAvailable, double discount) async {
    Map<String, dynamic> map = {
      'id': id,
      'is_available': isAvailable,
      'discount_value': discount
    };
    final userToken = authManager.getToken();
    return service
        .call(PromoEndPoints.editEndPoint(userToken: userToken, data: map));
  }

  Future deletePromo(int id) async {
    final userToken = authManager.getToken();
    return service
        .call(PromoEndPoints.deleteEndPoint(id: id, userToken: userToken));
  }
}

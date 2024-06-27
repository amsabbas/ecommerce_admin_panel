import 'package:ecommerce_admin/data/ads/datasource/end_points/ads_endpoints.dart';
import 'package:ecommerce_admin/data/ads/model/ad_model.dart';
import 'package:ecommerce_admin/data/base/network/service_generator.dart';
import 'package:ecommerce_admin/data/base/utils/auth_manager.dart';

class AdsRemoteDataSource {
  final ServiceGenerator service;
  final AuthManager authManager;

  AdsRemoteDataSource(
      {required this.service, required this.authManager});

  Future<List<AdModel>> getAllAds() async {
    return service.call(AdsEndPoints.getAllEndPoint()).then(
        (response) => response
            .map<AdModel>((e) => AdModel.fromJson(e))
            .toList());
  }

  Future addAd(String url) async {
    Map<String, String> map = {'photo_url': url};
    final userToken = authManager.getToken();
    return service.call(AdsEndPoints.addEndPoint(
        userToken: userToken, data: map));
  }

  Future deleteAd(int id) async {
    final userToken = authManager.getToken();
    return service.call(AdsEndPoints.deleteEndPoint(
        id: id, userToken: userToken));
  }
}

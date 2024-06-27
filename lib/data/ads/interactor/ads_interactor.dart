import 'package:ecommerce_admin/data/ads/model/ad_model.dart';
import 'package:ecommerce_admin/data/ads/repository/ads_repository_impl.dart';

class AdsInteractor {
  final AdsRepository repository;

  AdsInteractor({required this.repository});

  Future<List<AdModel>> getAllAds() async =>
      await repository.getAllAds();

  Future addAd(String name) async =>
      await repository.addAd(name);

  Future deleteAd(int id) async =>  await repository.deleteAd(id);
}

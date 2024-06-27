import 'package:ecommerce_admin/data/ads/datasource/ads_remote_data_source.dart';
import 'package:ecommerce_admin/data/ads/model/ad_model.dart';

class AdsRepository {
  final AdsRemoteDataSource remoteDataSource;

  AdsRepository({required this.remoteDataSource});

  Future<List<AdModel>> getAllAds() async {
    return await remoteDataSource.getAllAds();
  }

  Future addAd(String url) async {
    return await remoteDataSource.addAd(url);
  }

  Future deleteAd(int id) async {
    return await remoteDataSource.deleteAd(id);
  }
}

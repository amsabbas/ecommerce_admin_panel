import 'package:ecommerce_admin/data/base/network/service_generator.dart';
import 'package:ecommerce_admin/data/base/utils/auth_manager.dart';
import 'package:ecommerce_admin/data/file/datasource/end_points/file_endpoints.dart';

class FileRemoteDataSource {
  final ServiceGenerator service;
  final AuthManager authManager;

  FileRemoteDataSource({required this.service, required this.authManager});

  Future upload(String url) async {
    Map<String, String> map = {'photo_url': url};
    final userToken = authManager.getToken();
    return service
        .call(FileEndPoints.uploadEndPoint(userToken: userToken, data: map));
  }
}

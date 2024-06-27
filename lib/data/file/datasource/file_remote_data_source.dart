

import 'package:dio/dio.dart';
import 'package:ecommerce_admin/data/base/network/service_generator.dart';
import 'package:ecommerce_admin/data/base/utils/auth_manager.dart';
import 'package:ecommerce_admin/data/file/datasource/end_points/file_endpoints.dart';
import 'package:ecommerce_admin/data/file/model/file_model.dart';

class FileRemoteDataSource {
  final ServiceGenerator service;
  final AuthManager authManager;

  FileRemoteDataSource({required this.service, required this.authManager});

  Future<FileModel> upload(data) async {
    final MultipartFile file = MultipartFile.fromBytes(data, filename: "file");

    Map<String, dynamic> map = {'file': file};
    var headers = {"Content-Type": "multipart/form-data"};
    final userToken = authManager.getToken();
    return service
        .call(FileEndPoints.uploadEndPoint(
          userToken: userToken,
          data: map,
          headers: headers
        ))
        .then((response) => FileModel.fromJson(response));
  }
}

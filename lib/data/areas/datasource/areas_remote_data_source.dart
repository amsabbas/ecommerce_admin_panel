import 'package:ecommerce_admin/data/areas/datasource/end_points/areas_endpoints.dart';
import 'package:ecommerce_admin/data/areas/model/area_model.dart';
import 'package:ecommerce_admin/data/base/network/service_generator.dart';
import 'package:ecommerce_admin/data/base/utils/auth_manager.dart';

class AreasRemoteDataSource {
  final ServiceGenerator service;
  final AuthManager authManager;

  AreasRemoteDataSource({required this.service, required this.authManager});

  Future<List<AreaModel>> getAllAreas() async {
    final userToken = authManager.getToken();
    return service.call(AreasEndPoints.getAllEndPoint(userToken:userToken)).then((response) =>
        response.map<AreaModel>((e) => AreaModel.fromJson(e)).toList());
  }

  Future addArea(String name) async {
    Map<String, String> map = {'name': name};
    final userToken = authManager.getToken();
    return service
        .call(AreasEndPoints.addEndPoint(userToken: userToken, data: map));
  }

  Future deleteArea(int id) async {
    final userToken = authManager.getToken();
    return service
        .call(AreasEndPoints.deleteEndPoint(id: id, userToken: userToken));
  }
}

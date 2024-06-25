import 'package:ecommerce_admin/data/base/network/service_generator.dart';
import 'package:ecommerce_admin/data/base/utils/auth_manager.dart';
import 'package:ecommerce_admin/data/dashboard/datasource/end_points/dashboard_endpoints.dart';
import 'package:ecommerce_admin/data/dashboard/model/dashboard_data_model.dart';

class DashboardRemoteDataSource {
  final ServiceGenerator service;
  final AuthManager authManager;

  DashboardRemoteDataSource({required this.service, required this.authManager});

  Future<DashboardDataModel> getData() async {
    return service
        .call(DashboardEndPoints.dashboardDataEndPoint())
        .then((response) => DashboardDataModel.fromJson(response));
  }
}

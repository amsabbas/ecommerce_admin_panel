import 'package:ecommerce_admin/data/dashboard/datasource/dashboard_remote_data_source.dart';
import 'package:ecommerce_admin/data/dashboard/model/dashboard_data_model.dart';

class DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepository({required this.remoteDataSource});

  Future<DashboardDataModel> getData() async {
    return await remoteDataSource.getData();
  }
}

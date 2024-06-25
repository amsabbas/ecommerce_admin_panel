import 'package:ecommerce_admin/data/dashboard/model/dashboard_data_model.dart';
import 'package:ecommerce_admin/data/dashboard/repository/dashboard_repository_impl.dart';

class DashboardInteractor {
  final DashboardRepository repository;

  DashboardInteractor({required this.repository});

  Future<DashboardDataModel> getData() async => await repository.getData();
}

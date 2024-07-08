import 'package:ecommerce_admin/data/areas/datasource/areas_remote_data_source.dart';
import 'package:ecommerce_admin/data/areas/model/area_model.dart';

class AreasRepository {
  final AreasRemoteDataSource remoteDataSource;

  AreasRepository({required this.remoteDataSource});

  Future<List<AreaModel>> getAllAreas() async {
    return await remoteDataSource.getAllAreas();
  }

  Future addArea(String name, String nameAr) async {
    return await remoteDataSource.addArea(name, nameAr);
  }

  Future deleteArea(int id) async {
    return await remoteDataSource.deleteArea(id);
  }

  Future editArea(int id, String name, String nameAr) async {
    return await remoteDataSource.editArea(id, name, nameAr);
  }
}

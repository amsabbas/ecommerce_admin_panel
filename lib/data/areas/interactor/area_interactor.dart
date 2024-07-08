import 'package:ecommerce_admin/data/areas/model/area_model.dart';
import 'package:ecommerce_admin/data/areas/repository/areas_repository_impl.dart';

class AreaInteractor {
  final AreasRepository repository;

  AreaInteractor({required this.repository});

  Future<List<AreaModel>> getAllAreas() async => await repository.getAllAreas();

  Future addArea(String name) async => await repository.addArea(name);

  Future deleteArea(int id) async => await repository.deleteArea(id);

  Future editArea(int id, String name) async =>
      await repository.editArea(id, name);
}

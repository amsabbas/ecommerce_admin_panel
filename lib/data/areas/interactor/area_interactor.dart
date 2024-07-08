import 'package:ecommerce_admin/data/areas/model/area_model.dart';
import 'package:ecommerce_admin/data/areas/repository/areas_repository_impl.dart';

class AreaInteractor {
  final AreasRepository repository;

  AreaInteractor({required this.repository});

  Future<List<AreaModel>> getAllAreas() async => await repository.getAllAreas();

  Future addArea(String name, String nameAr) async =>
      await repository.addArea(name, nameAr);

  Future deleteArea(int id) async => await repository.deleteArea(id);

  Future editArea(int id, String name, String nameAr) async =>
      await repository.editArea(id, name, nameAr);
}

import 'package:ecommerce_admin/data/promos/model/promo_model.dart';
import 'package:ecommerce_admin/data/promos/repository/promo_repository_impl.dart';

class PromoInteractor {
  final PromoRepository repository;

  PromoInteractor({required this.repository});

  Future<List<PromoModel>> getAllPromos() async =>
      await repository.getAllPromos();

  Future addPromo(String code, bool isAvailable, double discount) async =>
      await repository.addPromo(code, isAvailable, discount);

  Future editPromo(int id, bool isAvailable, double discount) async =>
      await repository.editPromo(id, isAvailable, discount);

  Future deletePromo(int id) async => await repository.deletePromo(id);
}

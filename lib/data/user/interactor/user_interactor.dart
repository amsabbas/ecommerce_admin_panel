import 'package:ecommerce_admin/data/user/model/login_model.dart';
import 'package:ecommerce_admin/data/user/model/user_model.dart';

import '../repository/user_repository_impl.dart';

class UserInteractor {
  final UserRepository repository;

  UserInteractor({required this.repository});

  Future<LoginModel> login(String email, String password) async =>
      await repository.login(email, password);
}

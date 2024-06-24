import 'package:ecommerce_admin/data/base/utils/auth_manager.dart';
import 'package:ecommerce_admin/data/user/datasource/user_remote_data_source.dart';
import 'package:ecommerce_admin/data/user/model/login_model.dart';
import 'package:ecommerce_admin/data/user/model/user_model.dart';

class UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final AuthManager authManager;

  UserRepository({required this.remoteDataSource, required this.authManager});

  Future<LoginModel> login(String email, String password) async {
    LoginModel loginModel = await remoteDataSource.login(email, password);
    await authManager.saveToken(loginModel);
    return loginModel;
  }
}

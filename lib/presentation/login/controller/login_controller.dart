import 'package:ecommerce_admin/data/user/interactor/user_interactor.dart';
import 'package:get/get.dart';

import '../../../data/base/utils/app_logger.dart';
import '../../base/utils/result.dart';

class LoginController extends GetxController {
  final loginState = ResultState();
  late final UserInteractor userInteractor;

  LoginController({required this.userInteractor});

  void login(username, password) async {
    try {
      loginState.setLoading();
      loginState.setSuccess(await userInteractor.login(username, password));
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      loginState.setError(error);
    }
  }

  @override
  void dispose() {
    super.dispose();
    loginState.close();
  }
}

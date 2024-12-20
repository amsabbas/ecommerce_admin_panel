import 'package:ecommerce_admin/data/user/interactor/user_interactor.dart';
import 'package:ecommerce_admin/data/user/model/user_model.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final profileState = Rx<UserModel?>(null);
  final userState = Rx<UserModel?>(null);
  final logoutState = ResultState();

  late final UserInteractor userInteractor;

  UserController({required this.userInteractor});

  void getProfile() async {
    profileState.value = await userInteractor.getProfile();
    profileState.refresh();
  }

  void getSavedUser() async {
    userState.value = await userInteractor.getSavedUser();
    userState.refresh();
  }

  void logout() async {
    try {
      logoutState.setLoading();
      logoutState.setSuccess(await userInteractor.logout());
    } catch (error) {
      logoutState.setError(error);
    }
  }

  @override
  void dispose() {
    super.dispose();
    userState.close();
    logoutState.close();
  }
}

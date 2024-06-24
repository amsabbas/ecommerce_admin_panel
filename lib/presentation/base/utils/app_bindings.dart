import 'package:ecommerce_admin/presentation/base/controller/menu_controller.dart';
import 'package:ecommerce_admin/presentation/login/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/appsettings/datasource/local/settings_local_data_source.dart';
import '../../../data/appsettings/interactor/settings_interactor.dart';
import '../../../data/appsettings/repository/settings_repository.dart';
import '../../../data/base/network/service_generator.dart';
import '../../../data/base/utils/auth_manager.dart';
import '../../../data/user/datasource/user_remote_data_source.dart';
import '../../../data/user/interactor/user_interactor.dart';
import '../../../data/user/repository/user_repository_impl.dart';
import '../controller/app_settings_controller.dart';

class AppBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    await _addGeneralDependencies();
  }

  Future<void> _addGeneralDependencies() async {
    await Get.putAsync(() => SharedPreferences.getInstance(), permanent: true);
    Get.lazyPut(
        () => AuthManager(sharedPreferences: Get.find<SharedPreferences>()));

    Get.lazyPut(() => SettingsLocalDataSource(
        sharedPreferences: Get.find<SharedPreferences>()));
    Get.lazyPut(() => SettingsRepositoryImpl(
        localDataSource: Get.find<SettingsLocalDataSource>()));
    Get.lazyPut(() =>
        SettingsInteractor(repository: Get.find<SettingsRepositoryImpl>()));
    Get.lazyPut(() => AppSettingsController(
        settingsInteractor: Get.find<SettingsInteractor>()));

    Get.lazyPut(() => ServiceGenerator(
        "http://localhost/",
        Get.find<AuthManager>(),
        Get.find<SettingsLocalDataSource>()));

    Get.lazyPut(() => UserRemoteDataSource(
        service: Get.find<ServiceGenerator>(),
        authManager: Get.find<AuthManager>()));
    Get.lazyPut(() => UserRepository(
        authManager: Get.find<AuthManager>(),
        remoteDataSource: Get.find<UserRemoteDataSource>()));
    Get.lazyPut(() => UserInteractor(repository: Get.find<UserRepository>()));

    Get.lazyPut(
      () => LoginController(userInteractor: Get.find<UserInteractor>()),
    );

    Get.lazyPut(() => MenuAppController());
  }
}

import 'package:ecommerce_admin/data/appsettings/datasource/local/settings_local_data_source.dart';
import 'package:ecommerce_admin/data/appsettings/interactor/settings_interactor.dart';
import 'package:ecommerce_admin/data/appsettings/repository/settings_repository.dart';
import 'package:ecommerce_admin/data/base/network/service_generator.dart';
import 'package:ecommerce_admin/data/base/utils/auth_manager.dart';
import 'package:ecommerce_admin/data/categories/datasource/categories_remote_data_source.dart';
import 'package:ecommerce_admin/data/categories/interactor/category_interactor.dart';
import 'package:ecommerce_admin/data/categories/repository/categories_repository_impl.dart';
import 'package:ecommerce_admin/data/dashboard/datasource/dashboard_remote_data_source.dart';
import 'package:ecommerce_admin/data/dashboard/interactor/dashboard_interactor.dart';
import 'package:ecommerce_admin/data/dashboard/repository/dashboard_repository_impl.dart';
import 'package:ecommerce_admin/data/orders/datasource/orders_remote_data_source.dart';
import 'package:ecommerce_admin/data/orders/interactor/orders_interactor.dart';
import 'package:ecommerce_admin/data/orders/repository/orders_repository_impl.dart';
import 'package:ecommerce_admin/data/products/datasource/products_remote_data_source.dart';
import 'package:ecommerce_admin/data/products/interactor/products_interactor.dart';
import 'package:ecommerce_admin/data/products/repository/products_repository_impl.dart';
import 'package:ecommerce_admin/data/user/datasource/user_remote_data_source.dart';
import 'package:ecommerce_admin/data/user/interactor/user_interactor.dart';
import 'package:ecommerce_admin/data/user/repository/user_repository_impl.dart';
import 'package:ecommerce_admin/presentation/base/controller/menu_controller.dart';
import 'package:ecommerce_admin/presentation/base/controller/user_controller.dart';
import 'package:ecommerce_admin/presentation/dashboard/controller/dashboard_controller.dart';
import 'package:ecommerce_admin/presentation/login/controller/login_controller.dart';
import 'package:ecommerce_admin/presentation/products/controller/products_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/app_settings_controller.dart';

class AppBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    await _addGeneralDependencies();
    await _addCategoriesDependencies();
    await _addProductsDependencies();
    await _addOrdersDependencies();
    await _addDashboardDependencies();
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

    Get.lazyPut(() => ServiceGenerator("http://localhost:3000/",
        Get.find<AuthManager>(), Get.find<SettingsLocalDataSource>()));

    Get.lazyPut(() => UserRemoteDataSource(
        service: Get.find<ServiceGenerator>(),
        authManager: Get.find<AuthManager>()));
    Get.lazyPut(() => UserRepository(
        authManager: Get.find<AuthManager>(),
        remoteDataSource: Get.find<UserRemoteDataSource>()));
    Get.lazyPut(() => UserInteractor(repository: Get.find<UserRepository>()));

    Get.lazyPut(
      () => UserController(userInteractor: Get.find<UserInteractor>()),
    );

    Get.lazyPut(
      () => LoginController(userInteractor: Get.find<UserInteractor>()),
    );

    Get.lazyPut(() => MenuAppController());
  }

  Future<void> _addCategoriesDependencies() async {
    Get.lazyPut(() => CategoriesRemoteDataSource(
        service: Get.find<ServiceGenerator>(),
        authManager: Get.find<AuthManager>()));
    Get.lazyPut(() => CategoriesRepository(
        remoteDataSource: Get.find<CategoriesRemoteDataSource>()));
    Get.lazyPut(
        () => CategoryInteractor(repository: Get.find<CategoriesRepository>()));
  }

  Future<void> _addProductsDependencies() async {
    Get.lazyPut(() => ProductsRemoteDataSource(
        service: Get.find<ServiceGenerator>(),
        authManager: Get.find<AuthManager>()));
    Get.lazyPut(() => ProductsRepository(
        remoteDataSource: Get.find<ProductsRemoteDataSource>()));
    Get.lazyPut(
        () => ProductsInteractor(repository: Get.find<ProductsRepository>()));
    Get.lazyPut(
      () => ProductsController(
          productsInteractor: Get.find<ProductsInteractor>()),
    );
  }

  Future<void> _addOrdersDependencies() async {
    Get.lazyPut(() => OrdersRemoteDataSource(
        service: Get.find<ServiceGenerator>(),
        authManager: Get.find<AuthManager>()));
    Get.lazyPut(() =>
        OrdersRepository(remoteDataSource: Get.find<OrdersRemoteDataSource>()));
    Get.lazyPut(
        () => OrdersInteractor(repository: Get.find<OrdersRepository>()));
  }

  Future<void> _addDashboardDependencies() async {
    Get.lazyPut(() => DashboardRemoteDataSource(
        service: Get.find<ServiceGenerator>(),
        authManager: Get.find<AuthManager>()));
    Get.lazyPut(() => DashboardRepository(
        remoteDataSource: Get.find<DashboardRemoteDataSource>()));
    Get.lazyPut(
        () => DashboardInteractor(repository: Get.find<DashboardRepository>()));
    Get.lazyPut(
      () => DashboardController(
          userInteractor: Get.find<DashboardInteractor>(),
          orderInteractor: Get.find<OrdersInteractor>()),
    );
  }
}

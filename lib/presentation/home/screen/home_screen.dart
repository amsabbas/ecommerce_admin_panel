import 'package:ecommerce_admin/presentation/base/controller/menu_controller.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/widget/responsive_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/side_menu_widget.dart';
import 'package:ecommerce_admin/presentation/dashboard/screen/dashboard_screen.dart';
import 'package:ecommerce_admin/presentation/products/screen/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final MenuAppController menuController;

  @override
  void initState() {
    super.initState();
    menuController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<MenuAppController>(
        init: menuController, //here
        builder: (controller) {
          return Scaffold(
            key: menuController.scaffoldKey,
            drawer: const SideMenu(),
            body: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // We want this side menu only for large screen
                  if (Responsive.isDesktop(context))
                    const Expanded(
                      child: SideMenu(),
                    ),
                  Expanded(
                    flex: 5,
                    child: _getScreen(),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _getScreen() {
    switch (menuController.selectedMenu.value) {
      case MessageKeys.dashboardTitle:
        return const DashboardScreen();
      case MessageKeys.productsTitle:
        return const ProductsScreen();
      default:
        return const DashboardScreen();
    }
  }
}

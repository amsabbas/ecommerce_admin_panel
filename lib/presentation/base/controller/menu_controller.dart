import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuAppController extends GetxController {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  Rx<String> selectedMenu = MessageKeys.dashboardTitle.obs;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}

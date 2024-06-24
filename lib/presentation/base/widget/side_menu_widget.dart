import 'package:ecommerce_admin/presentation/base/controller/menu_controller.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/asset_resource.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MenuAppController menuController = Get.find();
    return Drawer(
      elevation: 1,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(AssetResource.appLogoImagePath),
          ),
          DrawerListTile(
            title: MessageKeys.dashboardTitle.tr,
            svgSrc: AssetResource.dashboardImagePath,
            press: () {
              menuController.selectedMenu.value = MessageKeys.dashboardTitle;
            },
          ),
          DrawerListTile(
            title: MessageKeys.productsTitle.tr,
            svgSrc: AssetResource.productsImagePath,
            press: () {
              menuController.selectedMenu.value = MessageKeys.productsTitle;
            },
          ),
          DrawerListTile(
            title: MessageKeys.logoutButtonTitle.tr,
            svgSrc: AssetResource.productsImagePath,
            press: () {

            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  });

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.ceruleanBlueColor),
      ),
    );
  }
}

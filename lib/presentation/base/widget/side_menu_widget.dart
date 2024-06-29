import 'package:ecommerce_admin/presentation/base/controller/menu_controller.dart';
import 'package:ecommerce_admin/presentation/base/controller/user_controller.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/asset_resource.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:ecommerce_admin/presentation/login/screen/login_screen.dart';
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
    UserController userController = Get.find();
    return Drawer(
      elevation: 1,
      child: ListView(
        children: [
          DrawerHeader(
            child: CircleAvatar(
              backgroundColor: AppColors.whiteColor,
              child: Image.asset(
                AssetResource.appLogoImagePath,
                width: 100,
                height: 100,
              ),
            ),
          ),
          DrawerListTile(
            title: MessageKeys.dashboardTitle.tr,
            svgSrc: AssetResource.dashboardImagePath,
            press: () {
              menuController.selectedMenu.value = MessageKeys.dashboardTitle;
            },
          ),
          const Divider(thickness: 0.2,),
          DrawerListTile(
            title: MessageKeys.adsTitle.tr,
            svgSrc: AssetResource.adsImagePath,
            press: () {
              menuController.selectedMenu.value = MessageKeys.adsTitle;
            },
          ),
          const Divider(thickness: 0.2,),
          DrawerListTile(
            title: MessageKeys.areasTitle.tr,
            svgSrc: AssetResource.areasImagePath,
            press: () {
              menuController.selectedMenu.value = MessageKeys.areasTitle;
            },
          ),
          const Divider(thickness: 0.2,),
          DrawerListTile(
            title: MessageKeys.categoriesTitle.tr,
            svgSrc: AssetResource.categoriesImagePath,
            press: () {
              menuController.selectedMenu.value = MessageKeys.categoriesTitle;
            },
          ),
          const Divider(thickness: 0.2,),
          DrawerListTile(
            title: MessageKeys.promosTitle.tr,
            svgSrc: AssetResource.promosImagePath,
            press: () {
              menuController.selectedMenu.value = MessageKeys.promosTitle;
            },
          ),
          const Divider(thickness: 0.2,),
          DrawerListTile(
            title: MessageKeys.productsTitle.tr,
            svgSrc: AssetResource.productsImagePath,
            press: () {
              menuController.selectedMenu.value = MessageKeys.productsTitle;
            },
          ),
          const Divider(thickness: 0.2,),
          DrawerListTile(
            title: MessageKeys.logoutButtonTitle.tr,
            svgSrc: AssetResource.logoutImagePath,
            press: () {
              userController.logout();
              Get.to(() => const LoginScreen());
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
        style:Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color:AppColors.ceruleanBlueColor),
      ),
    );
  }
}

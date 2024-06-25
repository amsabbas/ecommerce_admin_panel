import 'package:ecommerce_admin/presentation/base/controller/menu_controller.dart';
import 'package:ecommerce_admin/presentation/base/widget/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuHeaderWidget extends StatelessWidget {
  final String title;

  const MenuHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    MenuAppController menuController = Get.find();
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: menuController.controlMenu,
          ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}

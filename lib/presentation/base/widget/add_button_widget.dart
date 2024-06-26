import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddButtonWidget extends StatelessWidget {
  final Function onPressed;

  const AddButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed.call();
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.orangeColor,
        elevation: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            const Icon(
              Icons.add_circle_outline,
              color: AppColors.whiteColor,
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              MessageKeys.addButtonTitle.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.whiteColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

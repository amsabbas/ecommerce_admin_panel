import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  const ErrorWidget({super.key,required this.title,required this.message});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 32),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  MessageKeys.error.tr,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppColors.orangeColor,
                  ),
                ),
              ),
              SizedBox(
                width: 300.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColors.orangeColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(message),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

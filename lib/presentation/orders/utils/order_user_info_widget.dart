import 'package:ecommerce_admin/data/user/model/user_address_model.dart';
import 'package:ecommerce_admin/data/user/model/user_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderUserInfoWidget extends StatelessWidget {
  final UserModel userModel;
  final UserAddressModel userAddressModel;

  const OrderUserInfoWidget({
    super.key,
    required this.userModel,
    required this.userAddressModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MessageKeys.userInfo.tr,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.ceruleanBlueColor),
            ),
            const SizedBox(
              height: 8,
            ),
            _itemWidget(
                context, "${MessageKeys.userName.tr}: ", userModel.name.toString()),
            _itemWidget(context, "${MessageKeys.userEmail.tr}: ",
                userModel.email.toString()),
            _itemWidget(context, "${MessageKeys.userPhone.tr}: ",
                userModel.phone.toString()),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MessageKeys.userAddressInfo.tr,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold, color: AppColors.ceruleanBlueColor),
            ),
            const SizedBox(
              height: 8,
            ),
            _itemWidget(context, "${MessageKeys.userStreetName.tr}: ",
                userAddressModel.streetName.toString()),
            _itemWidget(context, "${MessageKeys.userBuildingNumber.tr}: ",
                userAddressModel.buildingNo.toString()),
            _itemWidget(context, "${MessageKeys.userFloorNumber.tr}: ",
                userAddressModel.floorNo.toString()),
            _itemWidget(context, "${MessageKeys.userApartmentNumber.tr}: ",
                userAddressModel.apartmentNo.toString()),
          ],
        )
      ],
    );
  }

  Widget _itemWidget(context, String key, String value) {
    return Row(
      children: [
        Text(
          key,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

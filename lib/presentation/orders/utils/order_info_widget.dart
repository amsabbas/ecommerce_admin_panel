import 'package:ecommerce_admin/data/orders/model/order_model.dart';
import 'package:ecommerce_admin/presentation/base/extension/string_extension.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderInfoWidget extends StatelessWidget {
  final OrderModel orderModel;

  const OrderInfoWidget({
    super.key,
    required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MessageKeys.orderInfo.tr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold, color: AppColors.ceruleanBlueColor),
        ),
        const SizedBox(
          height: 8,
        ),
        _itemWidget(
            context: context,
            key: "${MessageKeys.orderNo.tr}: ",
            value: orderModel.id.toString()),
        _itemWidget(
            context: context,
            key: "${MessageKeys.orderStatus.tr}: ",
            value: orderModel.status.getStatus(),
            color: orderModel.status.getStatusColor()),
        _itemWidget(
            context: context,
            key: "${MessageKeys.orderPaymentMethod.tr}: ",
            value: orderModel.paymentType),
        _itemWidget(
            context: context,
            key: "${MessageKeys.orderSubTotalPrice.tr}: ",
            value: orderModel.subtotal.toString()),
        _itemWidget(
            context: context,
            key: "${MessageKeys.orderDiscountPrice.tr}: ",
            value: orderModel.discount.toString()),
        _itemWidget(
            context: context,
            key: "${MessageKeys.orderDeliveryPrice.tr}: ",
            value: orderModel.deliveryFees.toString()),
        _itemWidget(
            context: context,
            key: "${MessageKeys.orderTotalPrice.tr}: ",
            value: orderModel.total.toString()),
      ],
    );
  }

  Widget _itemWidget(
      {required context,
      required String key,
      required String value,
      Color? color}) {
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
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color ?? AppColors.blackColor,
              ),
        ),
      ],
    );
  }
}

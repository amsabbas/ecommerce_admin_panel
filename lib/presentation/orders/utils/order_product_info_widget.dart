import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin/data/orders/model/order_info_model.dart';
import 'package:ecommerce_admin/data/products/model/product_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/constants.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProductInfoWidget extends StatelessWidget {
  final List<ProductModel> productModel;
  final List<OrderInfoModel> productInfoModel;

  const OrderProductInfoWidget({
    super.key,
    required this.productModel,
    required this.productInfoModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          MessageKeys.orderProductInfo.tr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold, color: AppColors.ceruleanBlueColor),
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _productsWidget(context),
        )
      ],
    );
  }

  List<Widget> _productsWidget(context) {
    return List.generate(productModel.length, (index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: "$scheme://${productModel[index].photoUrl}",
            width: 30,
            height: 30,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          _itemWidget(context, "${MessageKeys.productNameTitle.tr}: ",
              productModel[index].name.toString()),
          _itemWidget(context, "${MessageKeys.productQuantityTitle.tr}: ",
              "x${productInfoModel[index].quantity}"),
          _itemWidget(context, "${MessageKeys.productPriceTitle.tr}: ",
              productModel[index].price.toString()),
        ],
      );
    });
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

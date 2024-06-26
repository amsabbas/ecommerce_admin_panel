import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin/data/products/model/product_model.dart';
import 'package:ecommerce_admin/presentation/base/extension/string_extension.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDataSource extends DataTableSource {
  final void Function(ProductModel data) onDetailButtonPressed;

  final List<ProductModel> data;

  ProductDataSource({
    required this.data,
    required this.onDetailButtonPressed,
  });

  @override
  DataRow? getRow(int index) {
    final item = data[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(item.id.toString())),
      DataCell(Text(item.name.toString())),
      DataCell(
        CachedNetworkImage(
          imageUrl: item.photoUrl,
          width: 40,
          height: 40,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      DataCell(Text(item.price.toString())),
      DataCell(Text(item.quantity.toString())),
      DataCell(Text(item.isAvailable.toString().isAvailable())),
      DataCell(Builder(
        builder: (context) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: OutlinedButton(
                  onPressed: () => onDetailButtonPressed.call(item),
                  child: Text(
                    MessageKeys.editButtonTitle.tr,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.ceruleanBlueColor),
                  ),
                ),
              ),
            ],
          );
        },
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

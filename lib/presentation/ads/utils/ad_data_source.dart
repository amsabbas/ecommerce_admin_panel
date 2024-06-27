import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_admin/data/ads/model/ad_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdDataSource extends DataTableSource {
  final void Function(AdModel data) onDeleteButtonPressed;

  final List<AdModel> data;

  AdDataSource({
    required this.data,
    required this.onDeleteButtonPressed,
  });

  @override
  DataRow? getRow(int index) {
    final item = data[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(item.id.toString())),
      DataCell(
        CachedNetworkImage(
          imageUrl: "http://${item.photoUrl}",
          width: 40,
          height: 40,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      DataCell(Builder(
        builder: (context) {
          return OutlinedButton(
            onPressed: () => onDeleteButtonPressed.call(item),
            child: Text(
              MessageKeys.deleteButtonTitle.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.ceruleanBlueColor),
            ),
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

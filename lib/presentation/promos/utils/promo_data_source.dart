import 'package:ecommerce_admin/data/promos/model/promo_model.dart';
import 'package:ecommerce_admin/presentation/base/extension/string_extension.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromoDataSource extends DataTableSource {
  final void Function(PromoModel data) onDetailButtonPressed;
  final void Function(PromoModel data) onDeleteButtonPressed;
  final List<PromoModel> data;

  PromoDataSource({
    required this.data,
    required this.onDetailButtonPressed,
    required this.onDeleteButtonPressed,
  });

  @override
  DataRow? getRow(int index) {
    final item = data[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(item.id.toString())),
      DataCell(Text(item.code.toString())),
      DataCell(Text(item.discount.toString())),
      DataCell(Text(item.isAvailable.toString().isAvailable(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: item.isAvailable!
                  ? AppColors.greenColor
                  : AppColors.redColor))),
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
              const SizedBox(width: 4,),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: OutlinedButton(
                  onPressed: () => onDeleteButtonPressed.call(item),
                  child: Text(
                    MessageKeys.deleteButtonTitle.tr,
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

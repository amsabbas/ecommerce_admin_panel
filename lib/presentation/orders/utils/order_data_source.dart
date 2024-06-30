import 'package:ecommerce_admin/data/base/model/meta_paginated_model.dart';
import 'package:ecommerce_admin/data/orders/model/order_model.dart';
import 'package:ecommerce_admin/presentation/base/extension/date_string_extension.dart';
import 'package:ecommerce_admin/presentation/base/extension/string_extension.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDataSource extends DataTableSource {
  late List<OrderModel> data;
  late MetaPaginatedModel meta;

  final int itemPerRow;
  final void Function(OrderModel data) onDetailButtonPressed;

  OrderDataSource({
    required this.itemPerRow,
    required this.onDetailButtonPressed,
  });

  void setData(List<OrderModel> data, MetaPaginatedModel meta) {
    this.data = (data);
    this.meta = meta;
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index % itemPerRow >= data.length) {
      return null;
    }

    final item = data[index % itemPerRow];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(item.id.toString())),
      DataCell(Text(item.date.toString().getFormattedDate())),
      DataCell(Text(item.status.toString().getStatus(),
          style: TextStyle(
              color: item.status == "completed"
                  ? AppColors.greenColor
                  : AppColors.redColor))),
      DataCell(Text(item.total.toString())),
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
                    MessageKeys.detailButtonTitle.tr,
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
  int get rowCount => meta.itemCount;

  @override
  int get selectedRowCount => 0;
}

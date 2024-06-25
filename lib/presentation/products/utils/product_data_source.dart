import 'package:ecommerce_admin/data/products/model/product_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDataSource extends DataTableSource {
  final void Function(ProductModel data) onDetailButtonPressed;
  final void Function(ProductModel data) onDeleteButtonPressed;

  final List<ProductModel> data;

  ProductDataSource({
    required this.data,
    required this.onDetailButtonPressed,
    required this.onDeleteButtonPressed,
  });

  @override
  DataRow? getRow(int index) {
    final item = data[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(item.id.toString())),
      DataCell(Text(item.name.toString())),
      DataCell(Text(item.price.toString())),
      DataCell(Text(item.quantity.toString())),
      DataCell(Builder(
        builder: (context) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: OutlinedButton(
                  onPressed: () => onDetailButtonPressed.call(item),
                  child: Text(MessageKeys.editButtonTitle.tr),
                ),
              ),
              OutlinedButton(
                onPressed: () => onDeleteButtonPressed.call(item),
                child: Text(MessageKeys.deleteButtonTitle.tr),
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

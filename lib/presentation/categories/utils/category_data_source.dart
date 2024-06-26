import 'package:ecommerce_admin/data/categories/model/category_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDataSource extends DataTableSource {
  final void Function(CategoryModel data) onDetailButtonPressed;

  final List<CategoryModel> data;

  CategoryDataSource({
    required this.data,
    required this.onDetailButtonPressed,
  });

  @override
  DataRow? getRow(int index) {
    final item = data[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(item.id.toString())),
      DataCell(Text(item.name.toString())),
      DataCell(Builder(
        builder: (context) {
          return OutlinedButton(
            onPressed: () => onDetailButtonPressed.call(item),
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

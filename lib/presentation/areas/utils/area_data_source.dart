import 'package:ecommerce_admin/data/areas/model/area_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AreaDataSource extends DataTableSource {
  final void Function(AreaModel data) onDetailButtonPressed;
  final void Function(AreaModel data) onDeleteButtonPressed;
  final List<AreaModel> data;

  AreaDataSource({
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
      DataCell(Builder(
        builder: (context) {
          return Row(
            children: [
              OutlinedButton(
                onPressed: () => onDetailButtonPressed.call(item),
                child: Text(
                  MessageKeys.editButtonTitle.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.ceruleanBlueColor),
                ),
              ),
              const SizedBox(width: 8,),
              OutlinedButton(
                onPressed: () => onDeleteButtonPressed.call(item),
                child: Text(
                  MessageKeys.deleteButtonTitle.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.ceruleanBlueColor),
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

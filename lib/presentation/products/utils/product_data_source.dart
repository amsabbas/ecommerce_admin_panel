import 'dart:math';

import 'package:flutter/material.dart';

class ProductDataSource extends DataTableSource {
  final void Function(Map<String, dynamic> data) onDetailButtonPressed;
  final void Function(Map<String, dynamic> data) onDeleteButtonPressed;

  final _data = List.generate(200, (index) {
    return {
      'id': index + 1,
      'no': index + 1,
      'item': 'Item ${index + 1}',
      'price': Random().nextInt(10000),
      'date': '2022-06-30',
    };
  });

  ProductDataSource({
    required this.onDetailButtonPressed,
    required this.onDeleteButtonPressed,
  });

  @override
  DataRow? getRow(int index) {
    final data = _data[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(data['no'].toString())),
      DataCell(Text(data['item'].toString())),
      DataCell(Text(data['price'].toString())),
      DataCell(Text(data['date'].toString())),
      DataCell(Builder(
        builder: (context) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: OutlinedButton(
                  onPressed: () => onDetailButtonPressed.call(data),
                  child: const Text("Detail"),
                ),
              ),
              OutlinedButton(
                onPressed: () => onDeleteButtonPressed.call(data),
                child: const Text("Delete"),
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
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
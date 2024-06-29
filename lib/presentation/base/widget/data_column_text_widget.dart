import 'package:flutter/material.dart';

DataColumn generateDataColumn(
    BuildContext context, String text, bool isNumeric) {
  return DataColumn(
      label: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      numeric: isNumeric);
}

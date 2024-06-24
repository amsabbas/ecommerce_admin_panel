import 'package:flutter/material.dart';

class TableCardHeader extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final bool showDivider;
  final EdgeInsets padding;

  const TableCardHeader({
    super.key,
    required this.title,
    this.titleColor,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(16),
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding,
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: titleColor,
              ),
            ),
          ),
          Visibility(
            visible: showDivider,
            child: const Divider(
              height: 1.0,
              thickness: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

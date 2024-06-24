import 'dart:math';

import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/constants.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:ecommerce_admin/presentation/base/widget/table_card_header.dart';
import 'package:ecommerce_admin/presentation/dashboard/widget/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/widget/header_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dataTableHorizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [_titleWidget(), _infoCards(), _recentOrdersWidget()],
    );
  }

  Widget _titleWidget() {
    return HeaderWidget(
      title: MessageKeys.dashboardTitle.tr,
    );
  }

  Widget _infoCards() {
    final size = MediaQuery.of(context).size;
    final summaryCardCrossAxisCount = (size.width >= kScreenWidthLg ? 4 : 2);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final summaryCardWidth =
              ((constraints.maxWidth - (16 * (summaryCardCrossAxisCount - 1))) /
                  summaryCardCrossAxisCount);

          return Wrap(
            direction: Axis.horizontal,
            spacing: 16,
            runSpacing: 16,
            children: [
              DashboardCard(
                title: MessageKeys.newOrders.tr,
                value: '150',
                icon: Icons.shopping_cart_rounded,
                backgroundColor: AppColors.orangeColor,
                textColor: AppColors.whiteColor,
                iconColor: Colors.black12,
                width: summaryCardWidth,
              ),
              DashboardCard(
                title: MessageKeys.todaySales.tr,
                value: '+12%',
                icon: Icons.ssid_chart_rounded,
                backgroundColor: AppColors.greenColor,
                textColor: AppColors.whiteColor,
                iconColor: Colors.black12,
                width: summaryCardWidth,
              ),
              DashboardCard(
                title: MessageKeys.newUsers.tr,
                value: '44',
                icon: Icons.group_add_rounded,
                backgroundColor: AppColors.darkGrayColor,
                textColor: AppColors.whiteColor,
                iconColor: Colors.black12,
                width: summaryCardWidth,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _recentOrdersWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCardHeader(
              title: MessageKeys.recentOrders.tr,
              showDivider: false,
            ),
            SizedBox(
              width: double.infinity,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double dataTableWidth =
                      max(768.0, constraints.maxWidth);

                  return Scrollbar(
                    controller: _dataTableHorizontalScrollController,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _dataTableHorizontalScrollController,
                      child: SizedBox(
                        width: dataTableWidth,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: AppColors.lightGrayColor,
                          ),
                          child: DataTable(
                            showCheckboxColumn: false,
                            showBottomBorder: true,
                            columns: const [
                              DataColumn(label: Text('No.'), numeric: true),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Item')),
                              DataColumn(label: Text('Price'), numeric: true),
                            ],
                            rows: List.generate(5, (index) {
                              return DataRow.byIndex(
                                index: index,
                                cells: [
                                  DataCell(Text('#${index + 1}')),
                                  const DataCell(Text('2022-06-30')),
                                  DataCell(Text('Item ${index + 1}')),
                                  DataCell(Text('${Random().nextInt(10000)}')),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dataTableHorizontalScrollController.dispose();
    super.dispose();
  }
}

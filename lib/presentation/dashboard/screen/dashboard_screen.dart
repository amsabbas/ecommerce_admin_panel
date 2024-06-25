import 'dart:math';

import 'package:ecommerce_admin/data/dashboard/model/dashboard_data_model.dart';
import 'package:ecommerce_admin/data/orders/model/order_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/constants.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/loading_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/table_card_header.dart';
import 'package:ecommerce_admin/presentation/dashboard/controller/dashboard_controller.dart';
import 'package:ecommerce_admin/presentation/dashboard/widget/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/widget/menu_header_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dataTableScrollController = ScrollController();
  late final DashboardController _dashboardController;

  @override
  void initState() {
    super.initState();
    _dashboardController = Get.find();
    _dashboardController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<DashboardController>(
        init: _dashboardController, //here
        builder: (controller) {
          if (controller.dashboardState.value.state == CurrentState.success) {
            return ListView(padding: const EdgeInsets.all(16), children: [
              _titleWidget(),
              _infoCards(),
              _recentOrdersWidget()
            ]);
          } else {
            return loadingWidget(context);
          }
        });
  }

  Widget _titleWidget() {
    return MenuHeaderWidget(
      title: MessageKeys.dashboardTitle.tr,
    );
  }

  Widget _infoCards() {
    final size = MediaQuery.of(context).size;
    final summaryCardCrossAxisCount = (size.width >= kScreenWidthLg ? 4 : 2);
    DashboardDataModel data = _dashboardController.dataState.value.data;

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
                title: MessageKeys.dashboardTotalOrders.tr,
                value: data.totalOrders.toString(),
                icon: Icons.shopping_cart_rounded,
                backgroundColor: AppColors.orangeColor,
                textColor: AppColors.whiteColor,
                iconColor: AppColors.black12,
                width: summaryCardWidth,
              ),
              DashboardCard(
                title: MessageKeys.dashboardTodayOrders.tr,
                value: data.todayOrders.toString(),
                icon: Icons.ssid_chart_rounded,
                backgroundColor: AppColors.greenColor,
                textColor: AppColors.whiteColor,
                iconColor: AppColors.black12,
                width: summaryCardWidth,
              ),
              DashboardCard(
                title: MessageKeys.dashboardTotalUsers.tr,
                value: data.totalUsers.toString(),
                icon: Icons.group_add_rounded,
                backgroundColor: AppColors.darkGrayColor,
                textColor: AppColors.whiteColor,
                iconColor: AppColors.black12,
                width: summaryCardWidth,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _recentOrdersWidget() {
    List<OrderModel> orders = _dashboardController.ordersState.value.data;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCardHeader(
              title: MessageKeys.recentOrders.tr,
              showDivider: true,
            ),
            SizedBox(
              width: double.infinity,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double dataTableWidth =
                      max(kScreenWidthMd, constraints.maxWidth);
                  return Scrollbar(
                    controller: _dataTableScrollController,
                    thumbVisibility: true,
                    trackVisibility: true,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _dataTableScrollController,
                      child: SizedBox(
                        width: dataTableWidth,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: AppColors.lightGrayColor,
                          ),
                          child: DataTable(
                            showCheckboxColumn: false,
                            showBottomBorder: true,
                            columns: _dataColumn(),
                            rows: _dataRow(orders),
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

  List<DataColumn> _dataColumn() {
    return [
      DataColumn(label: Text(MessageKeys.noColumnTitle.tr), numeric: true),
      DataColumn(label: Text(MessageKeys.dateColumnTitle.tr)),
      DataColumn(label: Text(MessageKeys.priceColumnTitle.tr), numeric: true),
    ];
  }

  List<DataRow> _dataRow(orders) {
    return List.generate(orders.length, (index) {
      return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Text('#${orders[index].id}')),
          DataCell(Text(orders[index].date)),
          DataCell(Text('${orders[index].total}')),
        ],
      );
    });
  }

  @override
  void dispose() {
    _dataTableScrollController.dispose();
    super.dispose();
  }
}

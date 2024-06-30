import 'dart:math';

import 'package:ecommerce_admin/data/base/model/meta_paginated_model.dart';
import 'package:ecommerce_admin/data/orders/model/order_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/constants.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/data_column_text_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/error_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/loading_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/menu_header_widget.dart';
import 'package:ecommerce_admin/presentation/orders/controller/orders_controller.dart';
import 'package:ecommerce_admin/presentation/orders/screen/order_detail_screen.dart';
import 'package:ecommerce_admin/presentation/orders/utils/order_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _scrollController = ScrollController();
  late OrdersController _ordersController;
  late OrderDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    _ordersController = Get.find();
    _ordersController.resetOrders();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ordersController.getOrders(1);
    });
    _dataSource = OrderDataSource(
      itemPerRow: _ordersController.take,
      onDetailButtonPressed: (data) => {
        Get.to(
          const OrderDetailScreen(),
          arguments: data,
        )
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetX<OrdersController>(
        init: _ordersController,
        builder: (controller) {
          var state = controller.ordersState.value.state;
          if (state == CurrentState.success) {
            List<OrderModel> data = controller.ordersState.value.data!;
            MetaPaginatedModel meta = controller.metaState.value.data!;
            _dataSource.setData(data, meta);
            return SingleChildScrollView(
              primary: false,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuHeaderWidget(
                        title: MessageKeys.ordersTitle.tr,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final double dataTableWidth =
                            max(kScreenWidthMd, constraints.maxWidth);
                        return Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          trackVisibility: true,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            child: SizedBox(
                              width: dataTableWidth,
                              child: PaginatedDataTable(
                                  source: _dataSource,
                                  rowsPerPage: _ordersController.take,
                                  showCheckboxColumn: false,
                                  showFirstLastButtons: false,
                                  onPageChanged: (page) {
                                    _ordersController.getOrders(
                                        ((page) ~/ (_ordersController.take)) +
                                            1);
                                  },
                                  columns: _dataColumn()),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state == CurrentState.error) {
            return AppErrorWidget(
                title: MessageKeys.errorTitle.tr,
                message: MessageKeys.errorMessage.tr);
          } else {
            return loadingWidget(context);
          }
        });
  }

  List<DataColumn> _dataColumn() {
    return [
      generateDataColumn(context, MessageKeys.noColumnTitle.tr, false),
      generateDataColumn(context, MessageKeys.dateColumnTitle.tr, false),
      generateDataColumn(context, MessageKeys.statusColumnTitle.tr, false),
      generateDataColumn(context, MessageKeys.priceColumnTitle.tr, false),
      generateDataColumn(context, MessageKeys.actionsColumnTitle.tr, false)
    ];
  }
}

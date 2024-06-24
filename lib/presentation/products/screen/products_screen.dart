import 'dart:math';

import 'package:ecommerce_admin/presentation/base/controller/menu_controller.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/constants.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:ecommerce_admin/presentation/base/widget/header_widget.dart';
import 'package:ecommerce_admin/presentation/products/screen/product_detail_screen.dart';
import 'package:ecommerce_admin/presentation/products/utils/product_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _scrollController = ScrollController();
  late final ProductDataSource _dataSource;
  late final MenuAppController menuAppController;

  @override
  void initState() {
    super.initState();
    menuAppController = Get.find();
    _dataSource = ProductDataSource(
      onDetailButtonPressed: (data) => {Get.to(() => const ProductDetailScreen())},
      onDeleteButtonPressed: (data) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            HeaderWidget(
              title: MessageKeys.productsTitle.tr,
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
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: AppColors.lightGrayColor,
                          ),
                          child: PaginatedDataTable(
                            source: _dataSource,
                            rowsPerPage: 20,
                            showCheckboxColumn: false,
                            showFirstLastButtons: true,
                            columns: const [
                              DataColumn(label: Text('No.'), numeric: true),
                              DataColumn(label: Text('Item')),
                              DataColumn(label: Text('Price'), numeric: true),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Actions')),
                            ],
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
}

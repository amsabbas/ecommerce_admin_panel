import 'dart:math';

import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/constants.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/error_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/loading_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/menu_header_widget.dart';
import 'package:ecommerce_admin/presentation/products/controller/products_controller.dart';
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
  late ProductsController _productsController;
  late ProductDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    _productsController = Get.find();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productsController.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ProductsController>(
        init: _productsController, //here
        builder: (controller) {
          var state = controller.productsState.value.state;
          if (state == CurrentState.success) {
            _dataSource = ProductDataSource(
              data: controller.productsState.value.data,
              onDetailButtonPressed: (data) => {
                //Get.to(() => const ProductDetailScreen())
              },
              onDeleteButtonPressed: (data) {},
            );
            return SingleChildScrollView(
              primary: false,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  MenuHeaderWidget(
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
                                    rowsPerPage: 5,
                                    showCheckboxColumn: false,
                                    showFirstLastButtons: true,
                                    columns: _dataColumn()),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          else if (state == CurrentState.error) {
            return AppErrorWidget(
                title: MessageKeys.errorTitle.tr,
                message: MessageKeys.errorMessage.tr);
          }
          else {
            return loadingWidget(context);
          }
        });
  }

  List<DataColumn> _dataColumn() {
    return [
      DataColumn(label: Text(MessageKeys.noColumnTitle.tr), numeric: true),
      DataColumn(label: Text(MessageKeys.nameColumnTitle.tr)),
      DataColumn(label: Text(MessageKeys.priceColumnTitle.tr), numeric: true),
      DataColumn(label: Text(MessageKeys.quantityColumnTitle.tr)),
      DataColumn(label: Text(MessageKeys.actionsColumnTitle.tr))
    ];
  }
}

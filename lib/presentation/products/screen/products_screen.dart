import 'dart:math';

import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/constants.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/add_button_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/error_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/loading_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/menu_header_widget.dart';
import 'package:ecommerce_admin/presentation/products/controller/products_controller.dart';
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
            );
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
                        title: MessageKeys.productsTitle.tr,
                      ),
                      AddButtonWidget(
                        onPressed: () {
                          Get.to(() => const ProductDetailScreen(),
                              arguments: null);
                        },
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
                                  rowsPerPage: 5,
                                  showCheckboxColumn: false,
                                  showFirstLastButtons: true,
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
      _generateDataColumn(MessageKeys.noColumnTitle.tr, true),
      _generateDataColumn(MessageKeys.nameColumnTitle.tr, false),
      _generateDataColumn(MessageKeys.photoColumnTitle.tr, false),
      _generateDataColumn(MessageKeys.priceColumnTitle.tr, true),
      _generateDataColumn(MessageKeys.quantityColumnTitle.tr, true),
      _generateDataColumn(MessageKeys.isAvailableColumnTitle.tr, false),
      _generateDataColumn(MessageKeys.actionsColumnTitle.tr, false)
    ];
  }

  DataColumn _generateDataColumn(String text, bool isNumeric) {
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
}

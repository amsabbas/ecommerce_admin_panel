import 'dart:math';

import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/constants.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_dialogs.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_loading.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_snack_bar.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/add_button_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/data_column_text_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/error_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/loading_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/menu_header_widget.dart';
import 'package:ecommerce_admin/presentation/products/controller/products_controller.dart';
import 'package:ecommerce_admin/presentation/products/utils/product_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_detail_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _scrollController = ScrollController();
  late ProductsController _productsController;
  late ProductDataSource _dataSource;
  late Worker _deleteWorker;

  @override
  void initState() {
    super.initState();
    _productsController = Get.find();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productsController.getProducts();
    });
    _deleteWorker = ever(
        _productsController.deleteProductState,
        (ResultData res) => {
              res.handleState(
                  onLoading: () => CustomLoading.onLoading(context),
                  onError: () => CustomSnackBar.showFailureSnackBar(
                      title: MessageKeys.error.tr,
                      message: (res.error as AppErrorModel).message ??
                          MessageKeys.unKnown.tr),
                  onSuccess: () => _productsController.getProducts(),
                  onLoadingFinish: () => CustomLoading.dismissLoading(context))
            });
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ProductsController>(
        init: _productsController,
        builder: (controller) {
          var state = controller.productsState.value.state;
          if (state == CurrentState.success) {
            _dataSource = ProductDataSource(
                data: controller.productsState.value.data,
                onDetailButtonPressed: (data) => {
                      Get.to(() => const ProductDetailScreen(), arguments: data)
                    },
                onDeleteButtonPressed: (data) => {
                      CustomDialogs.showConfirmationDialog(
                          context: context,
                          title: MessageKeys.deleteTitle.tr,
                          message: MessageKeys.deleteMessage.tr,
                          positiveButtonTitle: MessageKeys.ok.tr,
                          negativeButtonTitle: MessageKeys.cancel.tr,
                          positiveCallBack: () {
                            _productsController.deleteProduct(data.id!);
                          })
                    });
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
      generateDataColumn(context, MessageKeys.noColumnTitle.tr, false),
      generateDataColumn(context, MessageKeys.nameColumnTitle.tr, false),
      generateDataColumn(context, MessageKeys.photoColumnTitle.tr, false),
      generateDataColumn(context, MessageKeys.priceColumnTitle.tr, false),
      generateDataColumn(context, MessageKeys.quantityColumnTitle.tr, false),
      generateDataColumn(context, MessageKeys.isAvailableColumnTitle.tr, false),
      generateDataColumn(context, MessageKeys.actionsColumnTitle.tr, false)
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _deleteWorker.dispose();
  }
}

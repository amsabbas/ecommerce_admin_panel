import 'dart:math';

import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/constants.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_loading.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_snack_bar.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/add_button_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/error_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/loading_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/menu_header_widget.dart';
import 'package:ecommerce_admin/presentation/categories/controller/categories_controller.dart';
import 'package:ecommerce_admin/presentation/categories/screen/category_detail_screen.dart';
import 'package:ecommerce_admin/presentation/categories/utils/category_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesState();
}

class _CategoriesState extends State<CategoriesScreen> {
  final _scrollController = ScrollController();
  late CategoriesController _categoriesController;
  late CategoryDataSource _dataSource;
  late Worker _deleteWorker;

  @override
  void initState() {
    super.initState();
    _categoriesController = Get.find();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _categoriesController.getCategories();
    });
    _deleteWorker = ever(
        _categoriesController.deleteCategoryState,
        (ResultData res) => {
              res.handleState(
                  onLoading: () => CustomLoading.onLoading(context),
                  onError: () => _showError(res.error as AppErrorModel),
                  onSuccess: () => _showSuccess(),
                  onLoadingFinish: () => CustomLoading.dismissLoading(context))
            });
  }

  @override
  Widget build(BuildContext context) {
    return GetX<CategoriesController>(
        init: _categoriesController, //here
        builder: (controller) {
          var state = controller.categoriesState.value.state;
          if (state == CurrentState.success) {
            _dataSource = CategoryDataSource(
              data: controller.categoriesState.value.data,
              onDetailButtonPressed: (data) =>
                  {_categoriesController.deleteCategory(data.id)},
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
                        title: MessageKeys.categoriesTitle.tr,
                      ),
                      AddButtonWidget(
                        onPressed: () {
                          Get.to(() => const CategoryDetailScreen());
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
      _generateDataColumn(MessageKeys.actionsColumnTitle.tr, true),

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

  void _showError(AppErrorModel result) {
    CustomSnackBar.showFailureSnackBar(
        title: MessageKeys.error.tr,
        message: result.message ?? MessageKeys.unKnown.tr);
  }

  void _showSuccess() {
    _categoriesController.getCategories();
  }

  @override
  void dispose() {
    super.dispose();
    _deleteWorker.dispose();
  }
}

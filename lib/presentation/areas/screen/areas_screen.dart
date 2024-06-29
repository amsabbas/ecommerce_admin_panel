import 'dart:math';

import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/presentation/areas/controller/areas_controller.dart';
import 'package:ecommerce_admin/presentation/areas/screen/area_detail_screen.dart';
import 'package:ecommerce_admin/presentation/areas/utils/area_data_source.dart';
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AreasScreen extends StatefulWidget {
  const AreasScreen({super.key});

  @override
  State<AreasScreen> createState() => _AreasState();
}

class _AreasState extends State<AreasScreen> {
  final _scrollController = ScrollController();
  late AreasController _areasController;
  late AreaDataSource _dataSource;
  late Worker _deleteWorker;

  @override
  void initState() {
    super.initState();
    _areasController = Get.find();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _areasController.getAreas();
    });
    _deleteWorker = ever(
        _areasController.deleteAreaState,
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
    return GetX<AreasController>(
        init: _areasController, //here
        builder: (controller) {
          var state = controller.areasState.value.state;
          if (state == CurrentState.success) {
            _dataSource = AreaDataSource(
              data: controller.areasState.value.data,
              onDetailButtonPressed: (data) => {
                CustomDialogs.showConfirmationDialog(
                    context: context,
                    title: MessageKeys.deleteTitle.tr,
                    message: MessageKeys.deleteMessage.tr,
                    positiveButtonTitle: MessageKeys.ok.tr,
                    negativeButtonTitle: MessageKeys.cancel.tr,
                    positiveCallBack: () {
                      _areasController.deleteArea(data.id);
                    })
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
                        title: MessageKeys.areasTitle.tr,
                      ),
                      AddButtonWidget(
                        onPressed: () {
                          Get.to(() => const AreaDetailScreen());
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
      generateDataColumn(context, MessageKeys.noColumnTitle.tr, true),
      generateDataColumn(context, MessageKeys.nameColumnTitle.tr, false),
      generateDataColumn(context, MessageKeys.actionsColumnTitle.tr, true),
    ];
  }

  void _showError(AppErrorModel result) {
    CustomSnackBar.showFailureSnackBar(
        title: MessageKeys.error.tr,
        message: result.message ?? MessageKeys.unKnown.tr);
  }

  void _showSuccess() {
    _areasController.getAreas();
  }

  @override
  void dispose() {
    super.dispose();
    _deleteWorker.dispose();
  }
}

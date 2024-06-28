import 'dart:math';

import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/constants.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_dialogs.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_loading.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_snack_bar.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/add_button_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/error_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/loading_widget.dart';
import 'package:ecommerce_admin/presentation/base/widget/menu_header_widget.dart';
import 'package:ecommerce_admin/presentation/promos/controller/promos_controller.dart';
import 'package:ecommerce_admin/presentation/promos/screen/promo_detail_screen.dart';
import 'package:ecommerce_admin/presentation/promos/utils/promo_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromosScreen extends StatefulWidget {
  const PromosScreen({super.key});

  @override
  State<PromosScreen> createState() => _PromosScreenState();
}

class _PromosScreenState extends State<PromosScreen> {
  final _scrollController = ScrollController();
  late PromosController _promosController;
  late PromoDataSource _dataSource;
  late Worker _deleteWorker;

  @override
  void initState() {
    super.initState();
    _promosController = Get.find();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _promosController.getPromos();
    });
    _deleteWorker = ever(
        _promosController.deletePromoState,
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
    return GetX<PromosController>(
        init: _promosController, //here
        builder: (controller) {
          var state = controller.promosState.value.state;
          if (state == CurrentState.success) {
            _dataSource = PromoDataSource(
              data: controller.promosState.value.data,
              onDetailButtonPressed: (data) =>
                  {Get.to(() => const PromoDetailScreen(), arguments: data)},
              onDeleteButtonPressed: (data) => {
                CustomDialogs.showConfirmationDialog(
                    context: context,
                    title: MessageKeys.deleteTitle.tr,
                    message: MessageKeys.deleteMessage.tr,
                    positiveButtonTitle: MessageKeys.ok.tr,
                    negativeButtonTitle: MessageKeys.cancel.tr,
                    positiveCallBack: () {
                      _promosController.deletePromo(data.id!);
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
                        title: MessageKeys.promosTitle.tr,
                      ),
                      AddButtonWidget(
                        onPressed: () {
                          Get.to(() => const PromoDetailScreen());
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
      _generateDataColumn(MessageKeys.noColumnTitle.tr, false),
      _generateDataColumn(MessageKeys.codeColumnTitle.tr, false),
      _generateDataColumn(MessageKeys.discountColumnTitle.tr, false),
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

  void _showError(AppErrorModel result) {
    CustomSnackBar.showFailureSnackBar(
        title: MessageKeys.error.tr,
        message: result.message ?? MessageKeys.unKnown.tr);
  }

  void _showSuccess() {
    _promosController.getPromos();
  }

  @override
  void dispose() {
    super.dispose();
    _deleteWorker.dispose();
  }
}

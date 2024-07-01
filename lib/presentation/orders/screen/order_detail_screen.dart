import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/data/orders/model/order_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/constants.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_loading.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_snack_bar.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/action_button_widget.dart';
import 'package:ecommerce_admin/presentation/orders/controller/orders_controller.dart';
import 'package:ecommerce_admin/presentation/orders/utils/order_info_widget.dart';
import 'package:ecommerce_admin/presentation/orders/utils/order_product_info_widget.dart';
import 'package:ecommerce_admin/presentation/orders/utils/order_user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends StatefulWidget {
  final int page;

  const OrderDetailScreen({
    super.key,
    required this.page,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late final OrdersController _ordersController;
  late final Worker _changeStatusWorker;
  late final OrderModel? _orderModel;

  @override
  void initState() {
    super.initState();
    _ordersController = Get.find();
    _orderModel = Get.arguments;
    _changeStatusWorker = ever(
        _ordersController.changeStatusState,
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800.0),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: Column(
                    children: [_titleWidget(), _contentWidget()],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                MessageKeys.orderDetailTitle.tr,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.ceruleanBlueColor,
                    ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.cancel_outlined),
                color: AppColors.ceruleanBlueColor,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          thickness: 0.7,
        ),
      ],
    );
  }

  Widget _contentWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OrderUserInfoWidget(
                userModel: _orderModel!.userModel!,
                userAddressModel: _orderModel.address!,
              ),
              const SizedBox(
                width: 16,
              ),
              OrderInfoWidget(
                orderModel: _orderModel,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          OrderProductInfoWidget(
            productModel: _orderModel.products!,
            productInfoModel: _orderModel.info!,
          ),
          _actionsButtonWidget(),
        ],
      ),
    );
  }

  Widget _actionsButtonWidget() {
    if (_orderModel!.status == pendingStatus) {
      return Padding(
        padding: const EdgeInsets.only(right: 32.0, left: 32.0, top: 16.0),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ActionButtonWidget(
                      isVisible: true,
                      title: MessageKeys.acceptButtonTitle.tr,
                      icon: Icons.check_circle_outline_rounded,
                      onPressed: () {
                        _ordersController.changeOrderStatus(
                            _orderModel.id, acceptedStatus);
                      }),
                  const SizedBox(
                    width: 8,
                  ),
                  ActionButtonWidget(
                      isVisible: true,
                      title: MessageKeys.rejectButtonTitle.tr,
                      icon: Icons.check_circle_outline_rounded,
                      onPressed: () {
                        _ordersController.changeOrderStatus(
                            _orderModel.id, rejectedStatus);
                      }),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  void _showError(AppErrorModel result) {
    CustomSnackBar.showFailureSnackBar(
        title: MessageKeys.error.tr,
        message: result.message ?? MessageKeys.unKnown.tr);
  }

  void _showSuccess() {
    _ordersController.getOrders(widget.page);
    Get.back();
  }

  @override
  void dispose() {
    super.dispose();
    _changeStatusWorker.dispose();
  }
}

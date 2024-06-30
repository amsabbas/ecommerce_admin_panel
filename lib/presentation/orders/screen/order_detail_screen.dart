import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/data/orders/model/order_model.dart';
import 'package:ecommerce_admin/presentation/base/extension/string_extension.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/constants.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_loading.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_snack_bar.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/action_button_widget.dart';
import 'package:ecommerce_admin/presentation/orders/controller/orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({
    super.key,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
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
            constraints: const BoxConstraints(maxWidth: 650.0),
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
          _orderInfoWidget(),
          _productInfoWidget(),
          _actionsButtonWidget(),
        ],
      ),
    );
  }

  Widget _orderInfoWidget() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              MessageKeys.noColumnTitle.tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              _orderModel!.id.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              MessageKeys.statusColumnTitle.tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              _orderModel.status.getStatus(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              MessageKeys.priceColumnTitle.tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              _orderModel.subtotal.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              MessageKeys.priceColumnTitle.tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              _orderModel.discount.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              MessageKeys.priceColumnTitle.tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              _orderModel.deliveryFees.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              MessageKeys.priceColumnTitle.tr,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              _orderModel.total.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ],
    );
  }

  Widget _productInfoWidget() {
    return Column(
        children: List.generate(_orderModel!.products!.length, (index) {
      return Column(
        children: [
          Row(
            children: [
              Text(
                MessageKeys.productNameTitle.tr,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                _orderModel.products![index].name.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                MessageKeys.quantityColumnTitle.tr,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                _orderModel.info![index].quantity.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                MessageKeys.priceColumnTitle.tr,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                _orderModel.products![index].price.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ],
      );
    }));
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
    _ordersController.getOrders(1);
    Get.back();
  }

  @override
  void dispose() {
    super.dispose();
    _changeStatusWorker.dispose();
  }
}

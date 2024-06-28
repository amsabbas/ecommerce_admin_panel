import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/data/promos/model/promo_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_loading.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_snack_bar.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/action_button_widget.dart';
import 'package:ecommerce_admin/presentation/promos/controller/promos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PromoDetailScreen extends StatefulWidget {
  const PromoDetailScreen({
    super.key,
  });

  @override
  State<PromoDetailScreen> createState() => _PromoDetailScreenState();
}

class _PromoDetailScreenState extends State<PromoDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final PromosController _promosController;
  late final Worker _addWorker;
  late final PromoModel? _promoModel;

  @override
  void initState() {
    super.initState();
    _promosController = Get.find();

    _promoModel = Get.arguments;
    _promosController.codeController.text = _promoModel?.code ?? "";
    _promosController.discountController.text =
        _promoModel?.discount != null ? _promoModel!.discount.toString() : "";
    _promosController.isAvailable.value = _promoModel?.isAvailable ?? true;

    _addWorker = ever(
        _promosController.addPromoState,
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
              padding: const EdgeInsets.all(64.0),
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
                MessageKeys.addPromoTitle.tr,
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
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _formWidgets(),
          _switchWidget(),
          _actionsButtonWidget(),
        ],
      ),
    );
  }

  Widget _switchWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("${MessageKeys.isAvailableColumnTitle.tr}: ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith()),
          const SizedBox(width: 16.0),
          ToggleSwitch(
            minWidth: 90.0,
            cornerRadius: 20.0,
            activeBgColors: const [
              [AppColors.greenColor],
              [AppColors.redColor]
            ],
            activeFgColor: AppColors.whiteColor,
            inactiveBgColor: AppColors.darkGrayColor,
            inactiveFgColor: AppColors.whiteColor,
            initialLabelIndex: _promosController.isAvailable.value ? 0 : 1,
            totalSwitches: 2,
            labels: [MessageKeys.yes.tr, MessageKeys.no.tr],
            radiusStyle: true,
            onToggle: (index) {
              _promosController.isAvailable.value = index == 0 ? true : false;
            },
          ),
        ],
      ),
    );
  }

  Widget _formWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: FormBuilderTextField(
            controller: _promosController.codeController,
            name: 'code',
            enabled: _promoModel == null,
            decoration: InputDecoration(
              labelText: MessageKeys.promoCodeTitle.tr,
              hintText: MessageKeys.codeColumnTitle.tr,
              border: const OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            validator: FormBuilderValidators.required(),
            onSaved: (value) =>
                (_promosController.codeController.text = value ?? ''),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: FormBuilderTextField(
            controller: _promosController.discountController,
            name: 'discount',
            decoration: InputDecoration(
              labelText: MessageKeys.promoDiscountTitle.tr,
              hintText: MessageKeys.discountColumnTitle.tr,
              border: const OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            keyboardType: TextInputType.number,
            validator: FormBuilderValidators.required(),
            onSaved: (value) =>
                (_promosController.discountController.text = value ?? ''),
          ),
        ),
      ],
    );
  }

  Widget _actionsButtonWidget() {
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
                    title: _promoModel != null
                        ? MessageKeys.editButtonTitle.tr
                        : MessageKeys.addButtonTitle.tr,
                    icon: Icons.check_circle_outline_rounded,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        if (_promoModel != null) {
                          _promosController.editPromo(_promoModel.id!);
                        } else {
                          _promosController.addPromo();
                        }
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showError(AppErrorModel result) {
    CustomSnackBar.showFailureSnackBar(
        title: MessageKeys.error.tr,
        message: result.message ?? MessageKeys.unKnown.tr);
  }

  void _showSuccess() {
    _promosController.getPromos();
    Get.back();
  }

  @override
  void dispose() {
    super.dispose();
    _addWorker.dispose();
  }
}

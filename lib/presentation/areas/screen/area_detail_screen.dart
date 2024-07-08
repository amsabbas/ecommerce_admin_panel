import 'package:ecommerce_admin/data/areas/model/area_model.dart';
import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/presentation/areas/controller/areas_controller.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_loading.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_snack_bar.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class AreaDetailScreen extends StatefulWidget {
  const AreaDetailScreen({
    super.key,
  });

  @override
  State<AreaDetailScreen> createState() => _AreaDetailScreenState();
}

class _AreaDetailScreenState extends State<AreaDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final AreasController _areasController;
  late final Worker _addWorker;
  late final AreaModel? _areaModel;

  @override
  void initState() {
    super.initState();
    _areasController = Get.find();
    _areasController.resetNameController();
    _areaModel = Get.arguments;
    if (_areaModel != null) {
      _areasController.nameController.text = _areaModel.name;
      _areasController.nameArController.text = _areaModel.nameAr;
    }
    _addWorker = ever(
        _areasController.addAreaState,
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
                    children: [_titleWidget(), _formWidget()],
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
                MessageKeys.addAreaTitle.tr,
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

  Widget _formWidget() {
    return FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: FormBuilderTextField(
              controller: _areasController.nameController,
              name: 'name',
              decoration: InputDecoration(
                labelText: MessageKeys.areaNameTitle.tr,
                hintText: MessageKeys.nameColumnTitle.tr,
                border: const OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              validator: FormBuilderValidators.required(),
              onSaved: (value) =>
                  (_areasController.nameController.text = value ?? ''),
            ),
          ),

          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: FormBuilderTextField(
              controller: _areasController.nameArController,
              name: 'name_ar',
              decoration: InputDecoration(
                labelText: MessageKeys.areaNameInArTitle.tr,
                hintText: MessageKeys.nameColumnTitle.tr,
                border: const OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              validator: FormBuilderValidators.required(),
              onSaved: (value) =>
              (_areasController.nameArController.text = value ?? ''),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32.0, left: 32.0, top: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ActionButtonWidget(
                          isVisible: true,
                          title: _areaModel != null
                              ? MessageKeys.editButtonTitle.tr
                              : MessageKeys.addButtonTitle.tr,
                          icon: Icons.check_circle_outline_rounded,
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState?.save();
                              if (_areaModel != null) {
                                _areasController.editArea(_areaModel.id);
                              } else {
                                _areasController.addArea();
                              }
                            }
                          }),
                    ],
                  ),
                ),
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
    _areasController.getAreas();
    Get.back();
  }

  @override
  void dispose() {
    super.dispose();
    _addWorker.dispose();
  }
}

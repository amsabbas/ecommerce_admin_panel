import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_loading.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_snack_bar.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/action_button_widget.dart';
import 'package:ecommerce_admin/presentation/categories/controller/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({
    super.key,
  });

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final CategoriesController _categoriesController;
  late final Worker _addWorker;

  @override
  void initState() {
    super.initState();
    _categoriesController = Get.find();
    _categoriesController.resetNameController();
    _addWorker = ever(
        _categoriesController.addCategoryState,
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
                MessageKeys.addCategoryTitle.tr,
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
              controller: _categoriesController.nameController,
              name: 'name',
              decoration: InputDecoration(
                labelText: MessageKeys.categoryNameTitle.tr,
                hintText: MessageKeys.nameColumnTitle.tr,
                border: const OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              validator: FormBuilderValidators.required(),
              onSaved: (value) =>
                  (_categoriesController.nameController.text = value ?? ''),
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
                          title: MessageKeys.addButtonTitle.tr,
                          icon: Icons.check_circle_outline_rounded,
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState?.save();
                              _categoriesController.addCategory();
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
    _categoriesController.getCategories();
    Get.back();
  }

  @override
  void dispose() {
    super.dispose();
    _addWorker.dispose();
  }
}

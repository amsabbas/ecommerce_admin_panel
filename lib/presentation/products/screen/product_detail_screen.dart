import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/data/categories/model/category_model.dart';
import 'package:ecommerce_admin/data/products/model/product_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/asset_resource.dart';
import 'package:ecommerce_admin/presentation/base/model/constants.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_loading.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_snack_bar.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/action_button_widget.dart';
import 'package:ecommerce_admin/presentation/products/controller/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final ProductsController _productsController;
  late final Worker _addWorker;
  late final ProductModel? _productModel;

  @override
  void initState() {
    super.initState();
    _productsController = Get.find();
    _productsController.getCategories();
    _setProductData();
    _addWorker = ever(
        _productsController.addProductState,
        (ResultData res) => {
              res.handleState(
                  onLoading: () => CustomLoading.onLoading(context),
                  onError: () => _showError(res.error as AppErrorModel),
                  onSuccess: () => _showSuccess(),
                  onLoadingFinish: () => CustomLoading.dismissLoading(context))
            });
  }

  void _setProductData() {
    _productModel = Get.arguments;
    _productsController.selectedCategory.value = _productModel?.category;
    _productsController.nameController.text = _productModel?.name ?? "";
    _productsController.descriptionController.text =
        _productModel?.description ?? "";
    _productsController.priceController.text =
        _productModel?.price != null ? _productModel!.price.toString() : "";
    _productsController.quantityController.text =
        _productModel?.quantity != null
            ? _productModel!.quantity.toString()
            : "";
    _productsController.file.value = _productModel?.photoUrl;
    _productsController.isAvailable.value = _productModel?.isAvailable ?? true;
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
                MessageKeys.addProductTitle.tr,
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
          Padding(
            padding: const EdgeInsets.only(right: 32.0, left: 32.0, top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_switchWidget(), _categoryWidget()],
            ),
          ),
          _fileWidget(),
          _actionsButtonWidget(),
        ],
      ),
    );
  }

  Widget _categoryWidget() {
    return GetX<ProductsController>(
        init: _productsController, //here
        builder: (controller) {
          List<CategoryModel>? categories =
              _productsController.categoriesState.value.data;
          CategoryModel? selectedCategory =
              _productsController.selectedCategory.value;
          if (categories != null) {
            return DropdownButton<CategoryModel>(
              hint: selectedCategory == null
                  ? Text(
                      MessageKeys.categoriesTitle.tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    )
                  : Text(selectedCategory.name,
                      style:
                          Theme.of(context).textTheme.bodyMedium?.copyWith()),
              items: categories.map((CategoryModel value) {
                return DropdownMenuItem<CategoryModel>(
                  value: value,
                  child: Text(value.name,
                      style:
                          Theme.of(context).textTheme.bodyMedium?.copyWith()),
                );
              }).toList(),
              onChanged: _productModel != null
                  ? null
                  : (value) {
                      _productsController.selectedCategory.value = value;
                    },
            );
          } else {
            return Container();
          }
        });
  }

  Widget _fileWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Row(
        children: [
          GetX<ProductsController>(
              init: _productsController, //here
              builder: (controller) {
                String? path = _productsController.pickedFile.value?.path;
                String? file = _productsController.file.value;
                if ((path == null && _productModel == null) ||
                    (file == null && _productModel != null)) {
                  return SvgPicture.asset(
                    AssetResource.imagePlaceHolderImagePath,
                    width: 40,
                    height: 40,
                  );
                } else {
                  return Image.network(
                    path ?? "$scheme://$file",
                    width: 40,
                    height: 40,
                  );
                }
              }),
          const SizedBox(width: 8),
          TextButton(
            child: Text(MessageKeys.chooseFileTitle.tr),
            onPressed: () async {
              _productsController.pickImage();
            },
          ),
        ],
      ),
    );
  }

  Widget _switchWidget() {
    return Row(
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
          initialLabelIndex: _productsController.isAvailable.value ? 0 : 1,
          totalSwitches: 2,
          labels: [MessageKeys.yes.tr, MessageKeys.no.tr],
          radiusStyle: true,
          onToggle: (index) {
            _productsController.isAvailable.value = index == 0 ? true : false;
          },
        ),
      ],
    );
  }

  Widget _formWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: FormBuilderTextField(
            controller: _productsController.nameController,
            name: 'name',
            decoration: InputDecoration(
              labelText: MessageKeys.productNameTitle.tr,
              hintText: MessageKeys.nameColumnTitle.tr,
              border: const OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            validator: FormBuilderValidators.required(),
            onSaved: (value) =>
                (_productsController.nameController.text = value ?? ''),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: FormBuilderTextField(
            controller: _productsController.descriptionController,
            name: 'description',
            decoration: InputDecoration(
              labelText: MessageKeys.productDescTitle.tr,
              hintText: MessageKeys.descColumnTitle.tr,
              border: const OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            validator: FormBuilderValidators.required(),
            onSaved: (value) =>
                (_productsController.descriptionController.text = value ?? ''),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: FormBuilderTextField(
            controller: _productsController.priceController,
            name: 'price',
            decoration: InputDecoration(
              labelText: MessageKeys.productPriceTitle.tr,
              hintText: MessageKeys.priceColumnTitle.tr,
              border: const OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            keyboardType: TextInputType.number,
            validator: FormBuilderValidators.required(),
            onSaved: (value) =>
                (_productsController.priceController.text = value ?? ''),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
          child: FormBuilderTextField(
            controller: _productsController.quantityController,
            name: 'quantity',
            decoration: InputDecoration(
              labelText: MessageKeys.productQuantityTitle.tr,
              hintText: MessageKeys.quantityColumnTitle.tr,
              border: const OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            keyboardType: TextInputType.number,
            validator: FormBuilderValidators.required(),
            onSaved: (value) =>
                (_productsController.quantityController.text = value ?? ''),
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
                    title: _productModel != null
                        ? MessageKeys.editButtonTitle.tr
                        : MessageKeys.addButtonTitle.tr,
                    icon: Icons.check_circle_outline_rounded,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        if (_productModel != null) {
                          _productsController.editProduct(_productModel.id!);
                        } else {
                          _productsController.addProduct();
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
    _productsController.getProducts();
    Get.back();
  }

  @override
  void dispose() {
    super.dispose();
    _addWorker.dispose();
  }
}

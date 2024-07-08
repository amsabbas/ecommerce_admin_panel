import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/data/categories/interactor/category_interactor.dart';
import 'package:ecommerce_admin/data/categories/model/category_model.dart';
import 'package:ecommerce_admin/data/file/interactor/file_interactor.dart';
import 'package:ecommerce_admin/data/file/model/file_model.dart';
import 'package:ecommerce_admin/data/products/interactor/products_interactor.dart';
import 'package:ecommerce_admin/data/products/model/product_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/base/utils/app_logger.dart';
import '../../base/utils/result.dart';

class ProductsController extends GetxController {
  final productsState = ResultState();
  final deleteProductState = ResultState();
  final addProductState = ResultState();
  final categoriesState = ResultState<List<CategoryModel>>();
  late final FileInteractor fileInteractor;
  late final ProductsInteractor productsInteractor;
  late final CategoryInteractor categoryInteractor;

  final nameController = TextEditingController();
  final nameArController = TextEditingController();
  final descriptionController = TextEditingController();
  final descriptionArController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final Rx<XFile?> pickedFile = Rx(null);
  final Rx<String?> file = Rx(null);
  final Rx<bool> isAvailable = Rx(true);
  final Rx<CategoryModel?> selectedCategory = Rx(null);

  ProductsController(
      {required this.productsInteractor,
      required this.fileInteractor,
      required this.categoryInteractor});

  void getProducts() async {
    try {
      productsState.setLoading();
      productsState
          .setSuccess(await productsInteractor.getAllProductsEndPoint());
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      productsState.setError(error);
    }
  }

  void getCategories() async {
    try {
      categoriesState.setLoading();
      categoriesState.setSuccess(await categoryInteractor.getAllCategories());
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      categoriesState.setError(error);
    }
  }

  void deleteProduct(int id) async {
    try {
      deleteProductState.setLoading();
      deleteProductState.setSuccess(await productsInteractor.deleteProduct(id));
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      deleteProductState.setError(error);
    }
  }

  void addProduct() async {
    _priceValidation();
    _quantityValidation();
    _categoryValidation();
    _fileValidation();
    try {
      addProductState.setLoading();
      FileModel model =
          await fileInteractor.upload(await pickedFile.value!.readAsBytes());
      addProductState.setSuccess(await productsInteractor.addProduct(
          ProductModel(
              id: null,
              category: null,
              name: nameController.text,
              nameAr: nameArController.text,
              description: descriptionController.text,
              descriptionAr: descriptionArController.text,
              photoUrl: model.filename,
              categoryId: selectedCategory.value!.id,
              quantity: int.parse(quantityController.text),
              isAvailable: isAvailable.value,
              price: double.parse(priceController.text))));
      pickedFile.value = null;
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      addProductState.setError(error);
    }
  }

  void editProduct(int id) async {
    _priceValidation();
    _quantityValidation();
    _categoryValidation();
    try {
      addProductState.setLoading();
      late String photoUrl;
      if (pickedFile.value?.path != null) {
        FileModel model =
            await fileInteractor.upload(await pickedFile.value!.readAsBytes());
        photoUrl = model.filename;
      } else {
        photoUrl = file.value!;
      }
      addProductState.setSuccess(await productsInteractor.editProduct(
          ProductModel(
              id: id,
              category: null,
              name: nameController.text,
              nameAr: nameArController.text,
              description: descriptionController.text,
              descriptionAr: descriptionArController.text,
              photoUrl: photoUrl,
              categoryId: selectedCategory.value!.id,
              quantity: int.parse(quantityController.text),
              isAvailable: isAvailable.value,
              price: double.parse(priceController.text))));
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      addProductState.setError(error);
    }
  }

  void _priceValidation() {
    if (!priceController.text.isNumericOnly) {
      addProductState
          .setError(AppErrorModel(MessageKeys.priceValidationMessage.tr));
      return;
    }
  }

  void _quantityValidation() {
    if (!quantityController.text.isNumericOnly) {
      addProductState
          .setError(AppErrorModel(MessageKeys.quantityValidationMessage.tr));
      return;
    }
  }

  void _categoryValidation() {
    if (selectedCategory.value == null) {
      addProductState
          .setError(AppErrorModel(MessageKeys.categoryValidationMessage.tr));
      return;
    }
  }

  void _fileValidation() {
    if (pickedFile.value?.path == null) {
      addProductState
          .setError(AppErrorModel(MessageKeys.imageValidationMessage.tr));
      return;
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    pickedFile.value = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
  }

  @override
  void dispose() {
    super.dispose();
    productsState.close();
    deleteProductState.close();
    addProductState.close();
    categoriesState.close();
  }
}

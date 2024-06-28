import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/data/promos/interactor/promo_interactor.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/base/utils/app_logger.dart';
import '../../base/utils/result.dart';

class PromosController extends GetxController {
  final promosState = ResultState();
  final addPromoState = ResultState();
  final deletePromoState = ResultState();

  final codeController = TextEditingController();
  final discountController = TextEditingController();
  final Rx<bool> isAvailable = Rx(true);

  late final PromoInteractor promoInteractor;

  PromosController({required this.promoInteractor});

  void getPromos() async {
    try {
      promosState.setLoading();
      promosState.setSuccess(await promoInteractor.getAllPromos());
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      promosState.setError(error);
    }
  }

  void addPromo() async {
    if (!discountController.text.isNumericOnly) {
      addPromoState
          .setError(AppErrorModel(MessageKeys.discountValidationMessage.tr));
      return;
    }
    try {
      addPromoState.setLoading();
      addPromoState.setSuccess(await promoInteractor.addPromo(
          codeController.text,
          isAvailable.value,
          double.parse(discountController.text)));
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      addPromoState.setError(error);
    }
  }

  void editPromo(int id) async {
    if (!discountController.text.isNumericOnly) {
      addPromoState
          .setError(AppErrorModel(MessageKeys.discountValidationMessage.tr));
      return;
    }
    try {
      addPromoState.setLoading();
      addPromoState.setSuccess(await promoInteractor.editPromo(
          id, isAvailable.value, double.parse(discountController.text)));
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      addPromoState.setError(error);
    }
  }

  void deletePromo(int id) async {
    try {
      deletePromoState.setLoading();
      deletePromoState.setSuccess(await promoInteractor.deletePromo(id));
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      deletePromoState.setError(error);
    }
  }

  @override
  void dispose() {
    super.dispose();
    promosState.close();
    addPromoState.close();
    deletePromoState.close();
  }
}

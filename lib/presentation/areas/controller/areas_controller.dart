import 'package:ecommerce_admin/data/areas/interactor/area_interactor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/base/utils/app_logger.dart';
import '../../base/utils/result.dart';

class AreasController extends GetxController {
  final areasState = ResultState();
  final addAreaState = ResultState();
  final deleteAreaState = ResultState();
  final nameController = TextEditingController();
  late final AreaInteractor areaInteractor;

  AreasController({required this.areaInteractor});

  void getAreas() async {
    try {
      areasState.setLoading();

      areasState.setSuccess(await areaInteractor.getAllAreas());
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      areasState.setError(error);
    }
  }

  void addArea() async {
    try {
      addAreaState.setLoading();
      addAreaState
          .setSuccess(await areaInteractor.addArea(nameController.text));
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      addAreaState.setError(error);
    }
  }

  void deleteArea(int id) async {
    try {
      deleteAreaState.setLoading();

      deleteAreaState.setSuccess(await areaInteractor.deleteArea(id));
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      deleteAreaState.setError(error);
    }
  }

  @override
  void dispose() {
    super.dispose();
    areasState.close();
    addAreaState.close();
    deleteAreaState.close();
  }
}

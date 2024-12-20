import 'package:ecommerce_admin/data/ads/interactor/ads_interactor.dart';
import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/data/file/interactor/file_interactor.dart';
import 'package:ecommerce_admin/data/file/model/file_model.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/base/utils/app_logger.dart';
import '../../base/utils/result.dart';

class AdsController extends GetxController {
  final adsState = ResultState();
  final addAdState = ResultState();
  final deleteAdState = ResultState();

  late final AdsInteractor adsInteractor;
  late final FileInteractor fileInteractor;

  Rx<XFile?> pickedFile = Rx(null);

  AdsController({required this.adsInteractor, required this.fileInteractor});

  void getAds() async {
    try {
      adsState.setLoading();
      adsState.setSuccess(await adsInteractor.getAllAds());
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      adsState.setError(error);
    }
  }

  void addAd() async {
    if (pickedFile.value?.path == null) {
      addAdState.setError(AppErrorModel(MessageKeys.imageValidationMessage.tr));
      return;
    }
    try {
      addAdState.setLoading();
      FileModel model =
          await fileInteractor.upload(await pickedFile.value!.readAsBytes());
      addAdState.setSuccess(await adsInteractor.addAd(model.filename));
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      addAdState.setError(error);
    }
  }

  void deleteAd(int id) async {
    try {
      deleteAdState.setLoading();
      deleteAdState.setSuccess(await adsInteractor.deleteAd(id));
    } catch (error, errorStack) {
      AppLogger.error(error: error, errorStack: errorStack);
      deleteAdState.setError(error);
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
    adsState.close();
    addAdState.close();
    deleteAdState.close();
  }
}

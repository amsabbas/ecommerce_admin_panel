import 'package:ecommerce_admin/data/base/model/app_error_model.dart';
import 'package:ecommerce_admin/presentation/ads/controller/ads_controller.dart';
import 'package:ecommerce_admin/presentation/base/language/language.dart';
import 'package:ecommerce_admin/presentation/base/model/asset_resource.dart';
import 'package:ecommerce_admin/presentation/base/style/colors.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_loading.dart';
import 'package:ecommerce_admin/presentation/base/utils/custom_snack_bar.dart';
import 'package:ecommerce_admin/presentation/base/utils/result.dart';
import 'package:ecommerce_admin/presentation/base/widget/action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AdDetailScreen extends StatefulWidget {
  const AdDetailScreen({
    super.key,
  });

  @override
  State<AdDetailScreen> createState() => _AdDetailScreenState();
}

class _AdDetailScreenState extends State<AdDetailScreen> {
  late final AdsController _adsController;
  late final Worker _addWorker;

  @override
  void initState() {
    super.initState();
    _adsController = Get.find();
    _adsController.pickedFile = Rx(null);
    _addWorker = ever(
        _adsController.addAdState,
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
                    children: [_titleWidget(), _fileWidget()],
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
                MessageKeys.addAddTitle.tr,
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

  Widget _fileWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 32.0, left: 32.0, top: 16.0),
          child: Row(
            children: [
              GetX<AdsController>(
                  init: _adsController, //here
                  builder: (controller) {
                    String? path = _adsController.pickedFile.value?.path;
                    if (path == null) {
                      return SvgPicture.asset(
                        AssetResource.imagePlaceHolderImagePath,
                        width: 40,
                        height: 40,
                      );
                    } else {
                      return Image.network(
                        path,
                        width: 40,
                        height: 40,
                      );
                    }
                  }),
              TextButton(
                child: Text(MessageKeys.chooseFileTitle.tr),
                onPressed: () async {
                  _adsController.pickImage();
                },
              ),
            ],
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
                          _adsController.addAd();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showError(AppErrorModel result) {
    CustomSnackBar.showFailureSnackBar(
        title: MessageKeys.error.tr,
        message: result.message ?? MessageKeys.unKnown.tr);
  }

  void _showSuccess() {
    _adsController.getAds();
    Get.back();
  }

  @override
  void dispose() {
    super.dispose();
    _addWorker.dispose();
  }
}

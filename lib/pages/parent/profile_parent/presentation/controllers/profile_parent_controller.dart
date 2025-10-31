import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../consts/colors.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../data/profile_parent_repository.dart';
import '../../model/update_notification_model.dart';

class ProfileParentController extends SuperController<dynamic> {
  ProfileParentController({required this.profileParentRepository});

  final IProfileParentRepository profileParentRepository;

  String selectedLanguage = AuthService.to.language; // Default is English

  final List<Map<String, dynamic>> languages = [
    {"code": "en", "flag": AppAssets.uk},
    {"code": "ar", "flag": AppAssets.saudiArabia},
  ];

  Future<void> openWhatsApp({required String phone, String? message}) async {
    final encodedMessage = Uri.encodeComponent(message ?? '');
    final url = Uri.parse('https://wa.me/$phone?text=$encodedMessage');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  UpdateNotificationModel? updateNotificationModel;
  RxBool isLoading = false.obs;
  Future<void> updateNotifications(int receiveNotifications) async {
    if (receiveNotifications == 0) {
      isOpen.value = true;
    } else {
      isOpen.value = false;
    }
    isLoading.value = true;
    profileParentRepository.updateNotifications(receiveNotifications: receiveNotifications).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          updateNotificationModel = null;
          updateNotificationModel = value.body;
          if (updateNotificationModel?.data?.receiveNotifications == 1) {
            isOpen.value = true;
          } else {
            isOpen.value = false;
          }
          // update();
        }
        isLoading.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      isLoading.value = false;
      if (receiveNotifications == 0) {
        isOpen.value = false;
      } else {
        isOpen.value = true;
      }
    });
  }

  RxBool isOpen = false.obs;

  @override
  void onInit() async {
    super.onInit();
    isOpen.value = AuthService.to.userInfo?.user?.receiveNotifications == 0 ? false : true;
    // Future.delayed(const Duration(seconds: 3)).then((value) {
    //   final isLoggedIn = AuthService.to.isLoggedIn.value;
    //   final isSelectedLanguage = AuthService.to.isSelectedLanguage.value;
    //   AuthService.to.selectLanguage(AuthService.to.language ?? 'en');
    //
    //   if (AuthService.to.isFirstTime) {
    //     Get.offNamed(Routes.BOARD);
    //   } else {
    //     if (isLoggedIn) {
    //       Get.offNamed(Routes.ProfileParent);
    //     } else {
    //       Get.offNamed(Routes.LOGIN);
    //     }
    //   }
    // });
  }

  RxBool isLoggingOut = false.obs;
  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}

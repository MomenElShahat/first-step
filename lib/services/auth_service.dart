import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../consts/storage.dart';
import '../main.dart';
import '../pages/auth/login/models/user_model.dart';
import '../pages/center/auth/signup/models/signup_response_model.dart';
import '../pages/lifecycle/presentation/controller/lifecycle_controller.dart';
import '../routes/app_pages.dart';

int? userId = 0;

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  GetStorage box = GetStorage(StorageKeys.userDataBox);
  GetStorage box2 = GetStorage(StorageKeys.appLanguage);
  GetStorage boxBoarding = GetStorage(StorageKeys.boarding);
  GetStorage splashImages = GetStorage(StorageKeys.splashImages);
  GetStorage vatData = GetStorage(StorageKeys.vatData);
  GetStorage statusDataBox = GetStorage(StorageKeys.statusData);
  GetStorage buttonsDataBox = GetStorage(StorageKeys.buttonsData);
  // GetStorage passwordBox = GetStorage(StorageKeys.password);
  final isLoggedIn = false.obs;
  final isSelectedLanguage = false.obs;
  bool isFirstTime = true;
  LoginResponseModel? userInfo;
  String language = "ar";
  static String fcmToken = "";
  bool? isParent;
  String? background;
  String? logo;
  String? splash;
  String? vatAr;
  String? vatEn;
  String? vatValue;
  String? taxAr;
  String? taxEn;
  String? taxValue;
  String? nameAr;
  String? nameEn;
  Color? plus;
  Color? minus;
  String googlePlayAppLink = 'https://play.google.com/store/apps/details?id=com.firststep.firststepapp';
  String appStoreAppLink = 'https://play.google.com/store/apps/details?id=com.example.myapp';
  String? startOfSubscription;
  String? endOfSubscription;
  String? subscriptionType;
  bool isAgreed = false;

  bool get isLoggedInValue => isLoggedIn.value;
  String? authToken;
  SignupResponseModel? userAccounteModel;
  bool? isUser;
  bool isGuest = false;
  // String? password;

  @override
  Future<void> onInit() async {
    super.onInit();
    // checkToken();
    isUser = await getBooleanValue();
    if (box.hasData(StorageKeys.userDataKey)) {
      isLoggedIn.value = true;
      userInfo = LoginResponseModel.fromJson(box.read(StorageKeys.userDataKey));
      // userAccounteModel = UserAccounteModel.fromJson(box.read(StorageKeys.profileDataKey));
    }
    if (box2.hasData(StorageKeys.language)) {
      isSelectedLanguage.value = true;
      language = box2.read(StorageKeys.language);
    }

    // if (passwordBox.hasData(StorageKeys.password)) {
    //   password = passwordBox.read(StorageKeys.password);
    // }

    if (boxBoarding.hasData(StorageKeys.boarding)) {
      // isFirstTime = BoardingModel.fromJson(boxBoarding.read(StorageKeys.boarding)).firstTime ?? true;
    }

    print("language $language");
  }
  //
  // void savePassword(String password) {
  //   this.password = password;
  //   passwordBox.write(StorageKeys.password, password);
  // }

  void login(LoginResponseModel userInfo) {
    isLoggedIn.value = true;
    this.userInfo = userInfo;
    box.write(StorageKeys.userDataKey, userInfo.toJson());
    startOfSubscription = userInfo.user?.subscriptionStartDate;
    endOfSubscription = userInfo.user?.subscriptionEndDate;
    NativeBridge.sendTokenToNative(userInfo.token ?? "");
    final controller = Get.find<LifecycleController>();
    controller.goOnline();
  }

  void saveProfileData(SignupResponseModel userAccounteModel) {
    this.userAccounteModel = userAccounteModel;
    box.write(StorageKeys.profileDataKey, userAccounteModel.toJson());
  }

  Color hexToColor(String hexColor) {
    // Ensure the string starts with '0xff' and remove the '#'
    final cleanHex = hexColor.replaceAll('#', '');
    return Color(int.parse('0xff$cleanHex'));
  }

  Future<void> logout() async {
    final controller = Get.find<LifecycleController>();
    await controller.goOffline();
    isLoggedIn.value = false;
    userInfo = null;
    // password = null;
    box.remove(StorageKeys.userDataKey);
    // passwordBox.remove(StorageKeys.password);
  }

  Future<void> logoutSignupCenter() async {
    final controller = Get.find<LifecycleController>();
    await controller.goOffline();
    isLoggedIn.value = false;
    userInfo = null;
    // password = null;
    box.remove(StorageKeys.userDataKey);
    // box.remove(StorageKeys.password);
    Get.offAllNamed(Routes.SIGNUP);
  }

  Future<void> logoutSignupParent() async {
    final controller = Get.find<LifecycleController>();
    await controller.goOffline();
    isLoggedIn.value = false;
    userInfo = null;
    // password = null;
    box.remove(StorageKeys.userDataKey);
    // box.remove(StorageKeys.password);
    Get.offAllNamed(Routes.SIGNUP_PARENT);
  }

  void selectLanguage(lan) {
    isSelectedLanguage.value = true;
    Get.updateLocale(Locale(lan));
    language = lan;
    box2.write(StorageKeys.language, lan);
  }

  Future<void> saveBooleanValue(bool value) async {
    print("saveBooleanValue $value");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isUser', value);
    isUser = value;
  }

  Future<bool> getBooleanValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isUser') ?? true;
  }

  void changeFirstTimeUSe(bool isFirstTime) {
    this.isFirstTime = isFirstTime;
    // boxBoarding.write(StorageKeys.boarding, BoardingModel(firstTime: isFirstTime).toJson());
  }
}

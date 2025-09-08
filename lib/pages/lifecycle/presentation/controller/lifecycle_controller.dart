import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_step/pages/lifecycle/data/lifecycle_repository.dart';
import 'package:first_step/services/auth_service.dart';

import '../../../../consts/colors.dart';
import '../../../../widgets/custom_snackbar.dart';

class LifecycleController extends GetxController with WidgetsBindingObserver {
  LifecycleController({required this.lifecycleRepository});
  final ILifecycleRepository lifecycleRepository;

  String? userStatus;
  RxBool _isOnline = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    debugPrint("📌 AuthService.userInfo: ${AuthService.to.userInfo}");

    if (AuthService.to.userInfo != null) {
      goOnline();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("⚙️ App state changed: $state");

    if (AuthService.to.userInfo == null) return;

    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("🔵 App resumed → Going online");
        goOnline();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        debugPrint("🔴 App background/closed → Going offline");
        goOffline();
        break;
      default:
        break;
    }
  }

  Future<void> goOnline() async {
    if (_isOnline.value) return;
    _isOnline.value = true;

    try {
      final response = await lifecycleRepository.goOnline();
      if (response.statusCode == 200 || response.statusCode == 201) {
        userStatus = response.body?.status;
        debugPrint("✅ User status: $userStatus");
        // update();
      }
    } catch (e, s) {
      debugPrint("❌ goOnline Error: $e\n$s");
      customSnackBar(e.toString(), ColorCode.danger600);
    }
  }

  Future<void> goOffline() async {
    if (!_isOnline.value) return;
    _isOnline.value = false;

    try {
      final response = await lifecycleRepository.goOffline();
      if (response.statusCode == 200 || response.statusCode == 201) {
        userStatus = response.body?.status;
        debugPrint("✅ User status: $userStatus");
        // update();
      }
    } catch (e, s) {
      debugPrint("❌ goOffline Error: $e\n$s");
      customSnackBar(e.toString(), ColorCode.danger600);
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    if (AuthService.to.userInfo != null) {
      goOffline();
    }
    super.onClose();
  }
}

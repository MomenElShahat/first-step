import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../resources/strings_generated.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../../../../consts/colors.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/pusher_service.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../data/notifications_parent_repository.dart';
import '../../model/parent_notifications_model.dart';


class NotificationsParentScreenController extends SuperController<dynamic> {
  NotificationsParentScreenController({required this.notificationsParentRepository});

  final INotificationsParentRepository notificationsParentRepository;

  List<ParentNotificationsModel> parentNotificationsModel = [];
  getParentNotifications() async {
    // isChildrenLoading.value = true;
    change(false, status: RxStatus.loading());
    notificationsParentRepository.getParentNotifications().then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          parentNotificationsModel.clear();
          parentNotificationsModel = value.body ?? [];
          update();
        }
        // isChildrenLoading.value = false;
        change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      change(true, status: RxStatus.success());
      // isChildrenLoading.value = false;
    });
  }

  readParentNotifications(String notificationId) async {
    // isChildrenLoading.value = true;
    // change(false, status: RxStatus.loading());
    notificationsParentRepository.readParentNotifications(notificationId).then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          customSnackBar(value.body ?? "", ColorCode.success600);
          await getParentNotifications();
          update();
        }
        // isChildrenLoading.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      // isChildrenLoading.value = false;
    });
  }

  readAllParentNotifications() async {
    // isChildrenLoading.value = true;
    // change(false, status: RxStatus.loading());
    notificationsParentRepository.readAllParentNotifications().then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          customSnackBar(value.body ?? "", ColorCode.success600);
          await getParentNotifications();
          update();
        }
        // isChildrenLoading.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      // isChildrenLoading.value = false;
    });
  }

  ScrollController scrollController = ScrollController();
  Future<void> _subscribeToParentNotificationsList() async {
    final userId = AuthService.to.userInfo?.user?.id;
    if (userId == null) return;

    await PusherService.to.subscribe(
      channelName: 'child-activity$userId',
      eventName: 'new-activity',
      onEvent: (data) {
        try {
          final parsed = jsonDecode(data);
          final newNotification = ParentNotificationsModel(

            createdAt: parsed["created_at"],
            id: parsed["id"],
            updatedAt: parsed["updated_at"],
          );
          parentNotificationsModel.add(newNotification);
          Future.delayed(
            const Duration(milliseconds: 300),
                () => scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            ),
          );
          update();
        } catch (e) {
          print("Error parsing new-message: $e");
        }
      },
    );
  }

  Future<void> onRefresh()  async{
    await getParentNotifications();
  }

  @override
  void onInit() async {
    change(true, status: RxStatus.success());
    await _subscribeToParentNotificationsList();
    await getParentNotifications();
    super.onInit();
    // Future.delayed(const Duration(seconds: 3)).then((value) {
    //   final isLoggedIn = AuthService.to.isLoggedIn.value;
    //   final isSelectedLanguage = AuthService.to.isSelectedLanguage.value;
    //   AuthService.to.selectLanguage(AuthService.to.language ?? 'en');
    //
    //   if (AuthService.to.isFirstTime) {
    //     Get.offNamed(Routes.BOARD);
    //   } else {
    //     if (isLoggedIn) {
    //       Get.offNamed(Routes.NotificationsParent);
    //     } else {
    //       Get.offNamed(Routes.LOGIN);
    //     }
    //   }
    // });
  }

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

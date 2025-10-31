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
import '../../../../booking_details/model/enrollment_details_model.dart';
import '../../../../parent/notifications_parent/model/parent_notifications_model.dart';
import '../../data/notifications_repository.dart';

class NotificationsScreenController extends SuperController<dynamic> {
  NotificationsScreenController({required this.notificationsRepository});

  final INotificationsRepository notificationsRepository;

  RxList<ParentNotificationsModel> parentNotificationsModel =
      <ParentNotificationsModel>[].obs;

  EnrollmentData? enrollmentData;

  Future<void> enrollmentRespond(
      {required int enrollmentId, required String respond}) async {
    List<Enrollment> enrollments = [];
    for (var element in parentNotificationsModel) {
      element.enrollment != null ? enrollments.add(element.enrollment!) : null;
    }
    if (respond == "rejected") {
      enrollments
          .firstWhere(
            (element) => element.id == enrollmentId,
          )
          .isRespondingReject
          .value = true;
    } else {
      enrollments
          .firstWhere(
            (element) => element.id == enrollmentId,
          )
          .isResponding
          .value = true;
    }
    // change(false, status: RxStatus.loading());
    notificationsRepository
        .enrollmentRespond(
            enrollmentId: enrollmentId.toString(), respond: respond)
        .then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          enrollmentData = null;
          enrollmentData = value.body;
          await getParentNotifications();
        }
        // change(true, status: RxStatus.success());
        if (respond == "rejected") {
          enrollments
              .firstWhere(
                (element) => element.id == enrollmentId,
              )
              .isRespondingReject
              .value = false;
          customSnackBar(
              AppStrings.reservationRejectedSuccessfully, ColorCode.success600);
        } else {
          enrollments
              .firstWhere(
                (element) => element.id == enrollmentId,
              )
              .isResponding
              .value = false;
          customSnackBar(
              AppStrings.reservationAcceptedSuccessfully, ColorCode.success600);
        }
        update();
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      if (respond == "rejected") {
        enrollments
            .firstWhere(
              (element) => element.id == enrollmentId,
            )
            .isRespondingReject
            .value = false;
      } else {
        enrollments
            .firstWhere(
              (element) => element.id == enrollmentId,
            )
            .isResponding
            .value = false;
      }
    });
  }

  enrollmentPaidUpdate(
      {required int enrollmentId, required String respond}) async {
    List<Enrollment> enrollments = [];
    for (var element in parentNotificationsModel) {
      element.enrollment != null ? enrollments.add(element.enrollment!) : null;
    }
    if (respond == "rejected") {
      enrollments
          .firstWhere(
            (element) => element.id == enrollmentId,
          )
          .isRespondingReject
          .value = true;
    } else {
      enrollments
          .firstWhere(
            (element) => element.id == enrollmentId,
          )
          .isResponding
          .value = true;
    }
    // change(false, status: RxStatus.loading());
    notificationsRepository
        .updateExistingToPaid(
            enrollmentId: enrollmentId.toString(), status: respond)
        .then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          enrollmentData = null;
          enrollmentData = value.body;
        }
        // change(true, status: RxStatus.success());
        if (respond == "rejected") {
          enrollments
              .firstWhere(
                (element) => element.id == enrollmentId,
              )
              .isRespondingReject
              .value = false;
          customSnackBar(
              AppStrings.reservationRejectedSuccessfully, ColorCode.success600);
        } else {
          enrollments
              .firstWhere(
                (element) => element.id == enrollmentId,
              )
              .isResponding
              .value = false;
          customSnackBar(
              AppStrings.reservationAcceptedSuccessfully, ColorCode.success600);
        }
        update();
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      if (respond == "rejected") {
        enrollments
            .firstWhere(
              (element) => element.id == enrollmentId,
            )
            .isRespondingReject
            .value = false;
      } else {
        enrollments
            .firstWhere(
              (element) => element.id == enrollmentId,
            )
            .isResponding
            .value = false;
      }
    });
  }

  RxBool isLoading = false.obs;

  Future<void> getParentNotifications() async {
    isLoading.value = true;
    // change(false, status: RxStatus.loading());
    notificationsRepository.getParentNotifications().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          parentNotificationsModel.value.clear();
          parentNotificationsModel.value.assignAll(value.body ?? []);
          parentNotificationsModel.refresh();
          // update();
        }
        isLoading.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isLoading.value = false;
    });
  }

  Future<void> readParentNotifications(String notificationId) async {
    isLoading.value = true;
    // change(false, status: RxStatus.loading());
    notificationsRepository.readParentNotifications(notificationId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          customSnackBar(value.body ?? "", ColorCode.success600);
          await getParentNotifications();
          // update();
        }
        isLoading.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isLoading.value = false;
    });
  }

  Future<void> readAllParentNotifications() async {
    isLoading.value = true;
    // change(false, status: RxStatus.loading());
    notificationsRepository.readAllParentNotifications().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          customSnackBar(value.body ?? "", ColorCode.success600);
          await getParentNotifications();
          // update();
        }
        isLoading.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      isLoading.value = false;
    });
  }

  ScrollController scrollController = ScrollController();

// inside NotificationsParentScreenController
  bool _isSubscribed = false;
  final String _channelName = 'universal-notifications';
  final String _eventName =
      r'Illuminate\Notifications\Events\BroadcastNotificationCreated';

  Future<void> _subscribeToParentNotificationsList() async {
    final userId = AuthService.to.userInfo?.user?.id;
    if (userId == null) return;
    if (_isSubscribed) {
      print('[NOTIF] already subscribed, skipping subscribe');
      return;
    }

    try {
      _isSubscribed = true;
      await PusherService.to.subscribe(
        channelName: _channelName,
        eventName: _eventName,
        onEvent: (dynamic data) {
          try {
            print('[PUSHER] raw event data: $data');

            // robust parsing: accept a Map or a JSON string
            dynamic payload;
            if (data == null) return;
            if (data is String) {
              payload = jsonDecode(data);
            } else {
              payload = data;
            }

            // Laravel may nest payload under "data" or "notification"
            final Map<String, dynamic> notifMap = (payload is Map)
                ? (payload['data'] ?? payload['notification'] ?? payload)
                    as Map<String, dynamic>
                : {};

            print('[PUSHER] parsed notification map: $notifMap');

            final newNotification = ParentNotificationsModel(
                date: notifMap["date"],
                createdAt: notifMap["created_at"],
                id: notifMap["id"],
                updatedAt: notifMap["updated_at"],
                description: notifMap["description"],
                enrollmentId: notifMap["enrollment_id"],
                notifiableId: notifMap["notifiable_id"],
                title: notifMap["title"],
                reportId: notifMap["report_id"],
                notifiableType: notifMap["notifiable_type"],
                readAt: notifMap["read_at"],
                notificationType: notifMap["notification_type"],
                time: notifMap["time"],
                type: notifMap["type"],
                enrollment: notifMap["enrollment"] != null
                    ? Enrollment.fromJson(notifMap["enrollment"])
                    : null,
                report: notifMap["report"] != null
                    ? Report.fromJson(notifMap["report"])
                    : null);

            // Insert and trigger UI update
            if (newNotification.notifiableId ==
                AuthService.to.userInfo?.user?.id) {
              parentNotificationsModel.insert(0, newNotification);
              parentNotificationsModel.refresh();
            }

            // safe scroll to top if attached
            if (scrollController.hasClients) {
              Future.delayed(const Duration(milliseconds: 300), () {
                if (scrollController.hasClients) {
                  scrollController.animateTo(
                    scrollController.position.minScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              });
            }
          } catch (e, st) {
            print('[PUSHER] onEvent handler error: $e\n$st');
          }
        },
      );
      print('[NOTIF] subscribed to $_channelName / $_eventName');
    } catch (e, st) {
      print('[NOTIF] subscribe failed: $e\n$st');
      _isSubscribed = false;
    }
  }

  @override
  void onClose() {
    // cleanup subscription to avoid duplicates
    try {
      PusherService.to.unsubscribe(_channelName);
      print('[NOTIF] unsubscribed from $_channelName on controller close');
    } catch (e) {
      print('[NOTIF] unsubscribe error: $e');
    }
    super.onClose();
  }

  Future<void> onRefresh() async {
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

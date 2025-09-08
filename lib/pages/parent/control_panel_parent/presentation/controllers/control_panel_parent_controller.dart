import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../../../../../resources/strings_generated.dart';
import '../../../../../consts/colors.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../services/pusher_service.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../center/control_panel/models/chats_model.dart';
import '../../../../center/control_panel/models/child_model.dart';
import '../../data/control_panel_parent_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../../models/daily_reports_model.dart';
import '../../models/nurseries_model.dart';
import '../../models/parent_enrollments_model.dart';
import '../widgets/chat_parent.dart';
import '../widgets/daily_report.dart';
import '../widgets/home_parent.dart';
import '../widgets/my_children.dart';
import '../widgets/reservations_parent.dart';

class ControlPanelParentController extends SuperController<dynamic> {
  ControlPanelParentController({required this.controlPanelParentRepository});

  final IControlPanelParentRepository controlPanelParentRepository;

  List<Widget Function()> pageBuilders = [
    // () => DashboardHomeParent(key: UniqueKey()),
    () => MyChildren(key: UniqueKey()),
    () => ReservationsParent(key: UniqueKey()),
    () => DailyReports(key: UniqueKey()),
    () => ChatParent(key: UniqueKey()),
  ];

  // final childrenList = List<int>.generate(5, (index) => index).obs;

  List<ChildModel>? children;
  List<NurseriesModel>? nurseries;

  // RxBool isChildrenLoading = false.obs;
  getChildren() async {
    // isChildrenLoading.value = true;
    change(false, status: RxStatus.loading());
    controlPanelParentRepository.getChildren().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          children = null;
          children = value.body;
          await getDailyReports(children ?? []);
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

  getNurseries() async {
    // isChildrenLoading.value = true;
    change(false, status: RxStatus.loading());
    controlPanelParentRepository.getNurseries().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          nurseries = null;
          nurseries = value.body;
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

  List<DailyReport>? dailyReports;

  // RxBool isChildrenLoading = false.obs;
  getDailyReports(List<ChildModel> children) async {
    // isChildrenLoading.value = true;
    change(false, status: RxStatus.loading());
    controlPanelParentRepository.getDailyReports().then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          dailyReports = null;
          dailyReports = value.body?.data ?? [];
          for (int i = 0; i < children.length; i++) {
            final filteredReports = dailyReports?.where((report) => report.child?.id == children[i].id).toList().length;
            children[i].reportsCount = filteredReports ?? 0;
          }
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



  RxBool isDeletingBranch = false.obs;

  deleteChild(String childId) async {
    isDeletingBranch.value = true;
    controlPanelParentRepository.deleteChild(childId).then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 204) {
          customSnackBar(value.body ?? "", ColorCode.success600);
          Get.back();
          await getChildren();
          update();
        }
        isDeletingBranch.value = false;
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      isDeletingBranch.value = false;
    });
  }

  String formatDate(String rawDate) {
    final dateTime = DateTime.parse(rawDate);
    final formatted = DateFormat('d / M / y').format(dateTime);
    return formatted;
  }

  int? selectedChildId;

  getChildrenReportsCount() {
    final filteredReports = dailyReports?.where((report) => report.child?.id == selectedChildId).toList();
  }

  // void toggleChildFilter(int childId) {
  //   if (selectedChildId == childId) {
  //     // Clicked again → unselect
  //     selectedChildId = null;
  //   } else {
  //     selectedChildId = childId;
  //   }
  //   currentPage = 1;
  //   update();
  // }

  List<int> selectedChildIds = [];

  void toggleChildFilter(int childId) {
    if (selectedChildIds.contains(childId)) {
      selectedChildIds.remove(childId);
    } else {
      selectedChildIds.add(childId);
    }
    update();
  }

  bool isChildSelected(int childId) => selectedChildIds.contains(childId);

  Future<void> onRefresh() async {
    await getChildren();
    await getNurseries();
    await getDailyReports(children ?? []);
  }

  int currentPage = 1;
  int rowsPerPage = 10;

  List<NurseriesModel> getParentsNotInChats() {
    final Set<int> contactIdsInChats = chats?.where((chat) => chat.contactId != null)
        .map((chat) => chat.contactId!)
        .toSet() ?? <int>{};

    // Filter parents whose IDs are not in the contactIdsInChats
    return nurseries?.where((nursery) => nursery.id != null && !contactIdsInChats.contains(nursery.id))
        .toList() ?? [];
  }

  List<Contacts>? chats;

  getChats() async {
    // isParentsLoading.value = true;
    // change(false, status: RxStatus.loading());
    controlPanelParentRepository.getChats().then(
          (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          chats = null;
          chats = value.body;
          update();
        }
        // isParentsLoading.value = false;
        // change(true, status: RxStatus.success());
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      // change(true, status: RxStatus.success());
      // isParentsLoading.value = false;
    });
  }

  final arabicRegex = RegExp(r'^[\u0600-\u06FF\s]+$');

  String getFirstTwoCapitalLetters(String input) {
    String trimmed = input.trim();

    if (trimmed.length < 2) return '';

    // Arabic check
    final arabicRegex = RegExp(r'^[\u0600-\u06FF\s]+$');
    final englishRegex = RegExp(r'^[a-zA-Z\s]+$');

    if (arabicRegex.hasMatch(trimmed)) {
      // Extract first two Arabic letters
      List<String> letters = trimmed.runes
          .where((r) => RegExp(r'[\u0600-\u06FF]').hasMatch(String.fromCharCode(r)))
          .take(1)
          .map((r) => String.fromCharCode(r))
          .toList();

      return letters.length == 1 ? letters[0] : '';
    }

    if (englishRegex.hasMatch(trimmed)) {
      String firstTwo = trimmed.substring(0, 2);
      return firstTwo.toUpperCase();
    }

    return '';
  }


  List<NurseriesModel> chatNurseries = [];

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    await _initData();
    await _subscribeToChatList();
  }

  Future<void> _initData() async {
    await getChildren();
    await getNurseries();
    chatNurseries = getParentsNotInChats();
    await getChats();
  }

  Future<void> _subscribeToChatList() async {
    final userId = AuthService.to.userInfo?.user?.id;
    if (userId == null) return;

    await PusherService.to.subscribe(
      channelName: 'chat-list.$userId',
      eventName: 'chat-list-updated',
      onEvent: (data) {
        try {
          final parsed = jsonDecode(data) as Map<String, dynamic>;
          final contactsJson = parsed["contacts"] as List<dynamic>;
          chats = contactsJson.map((e) => Contacts.fromJson(e as Map<String, dynamic>)).toList();
          update();
        } catch (e) {
          print("Error parsing chat-list-updated: $e");
        }
      },
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      await _subscribeToChatList();
      await getChats();
    }
  }

  @override
  void onClose() async {
    final userId = AuthService.to.userInfo?.user?.id;
    if (userId != null) {
      await PusherService.to.unsubscribe('chat-list.$userId');
    }
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  // void onInit() async {
  //   change(true, status: RxStatus.success());
  //   await getChildren();
  //   await getNurseries();
  //   WidgetsBinding.instance.addObserver(this);
  //   await initPusher();
  //   super.onInit();
  // }

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

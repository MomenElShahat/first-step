import 'package:first_step/pages/parent/notifications_parent/presentation/views/notifications_parent_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../services/auth_service.dart';
import '../../center/blog/presentation/views/blog_view.dart';
import '../../center/control_panel/presentation/views/control_panel_view.dart';
import '../../center/control_panel/presentation/widgets/chat.dart';
import '../../center/control_panel/presentation/widgets/childrens_files.dart';
import '../../center/control_panel/presentation/widgets/daily_report_center.dart';
import '../../center/control_panel/presentation/widgets/home.dart';
import '../../center/control_panel/presentation/widgets/my_branches.dart';
import '../../center/control_panel/presentation/widgets/notifications.dart';
import '../../center/control_panel/presentation/widgets/reservations.dart';
import '../../center/control_panel/presentation/widgets/work_team.dart';
import '../../center/home/presentation/views/home_view.dart';
import '../../center/notifications/presentation/views/notifications_view.dart';
import '../../center/profile/presentation/views/profile_view.dart';
import '../../center/search/presentation/views/search_view.dart';
import '../../parent/blog_parent/presentation/views/blog_parent_view.dart';
import '../../parent/control_panel_parent/presentation/views/control_panel_parent_view.dart';
import '../../parent/control_panel_parent/presentation/widgets/chat_parent.dart';
import '../../parent/control_panel_parent/presentation/widgets/daily_report.dart';
import '../../parent/control_panel_parent/presentation/widgets/home_parent.dart';
import '../../parent/control_panel_parent/presentation/widgets/my_children.dart';
import '../../parent/control_panel_parent/presentation/widgets/reservations_parent.dart';
import '../../parent/home_parent/presentation/views/home_parent_view.dart';
import '../../parent/profile_parent/presentation/views/profile_parent_view.dart';
import '../../parent/search_parent/presentation/views/search_parent_view.dart';

class MainController extends SuperController<bool> {
  MainController();

  // late final PersistentTabController bottomController = PersistentTabController(initialIndex: 0);

  RxBool isExpired = false.obs;
  List<Widget> pageList = <Widget>[];

  RxBool isDrawerScreenActive = false.obs;

  // List<Widget> drawerScreensList = AuthService.to.userInfo?.user?.role == "center" ? <Widget>[
  //   DashboardHome(key: UniqueKey()),
  //   MyBranches(key: UniqueKey()),
  //   ChildrensFiles(key: UniqueKey()),
  //   Reservations(key: UniqueKey()),
  //   DailyReportCenter(key: UniqueKey()),
  //   Chat(key: UniqueKey()),
  //   // Notifications(key: UniqueKey()),
  //   WorkTeam(key: UniqueKey()),
  // ] : <Widget>[
  //   // DashboardHome(key: UniqueKey()),
  //   // MyBranches(key: UniqueKey()),
  //   ChildrensFiles(key: UniqueKey()),
  //   Reservations(key: UniqueKey()),
  //   DailyReportCenter(key: UniqueKey()),
  //   Chat(key: UniqueKey()),
  //   // Notifications(key: UniqueKey()),
  //   WorkTeam(key: UniqueKey()),
  // ];

  // List<Widget> drawerScreensParentList = <Widget>[
  //   // DashboardHomeParent(key: UniqueKey()),
  //   MyChildren(key: UniqueKey()),
  //   ReservationsParent(key: UniqueKey()),
  //   DailyReports(key: UniqueKey()),
  //   ChatParent(key: UniqueKey()),
  // ];

  RxInt? selectedIndex;
  RxInt currentIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex?.value = index;
    isDrawerScreenActive.value = false;
    currentIndex.value = 0;
  }

  RxInt? tab;
  @override
  void onInit() {
    // AuthService.to.changeFirstTimeUSe(false);
    var args = Get.arguments;
    tab = args;
    selectedIndex = tab ?? 2.obs;
    pageList = <Widget>[
      (AuthService.to.userInfo?.user?.role == "parent")
          ? ControlPanelParentScreen(openDrawer: () {}, currentIndex: currentIndex)
          : ControlPanelScreen(openDrawer: () {}, currentIndex: currentIndex),
      (AuthService.to.userInfo?.user?.role == "parent") ? const BlogParentScreen() : const BlogScreen(),
      (AuthService.to.userInfo?.user?.role == "parent") ? const HomeParentScreen() : const HomeScreen(),
      (AuthService.to.userInfo?.user?.role == "parent")
          ? const NotificationsParentScreen()
          : const NotificationsScreen(),
      (AuthService.to.userInfo?.user?.role == "parent") ? const ProfileParentScreen() : const ProfileScreen(),
    ];
    super.onInit();
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

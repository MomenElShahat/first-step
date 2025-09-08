import 'package:first_step/services/auth_service.dart';
import 'package:get/get.dart';

import '../../center/blog/data/blog_api_provider.dart';
import '../../center/blog/data/blog_repository.dart';
import '../../center/blog/presentation/controllers/blog_controller.dart';
import '../../center/control_panel/data/control_panel_api_provider.dart';
import '../../center/control_panel/data/control_panel_repository.dart';
import '../../center/control_panel/presentation/controllers/control_panel_controller.dart';
import '../../center/home/data/home_api_provider.dart';
import '../../center/home/data/home_repository.dart';
import '../../center/home/presentation/controllers/home_controller.dart';
import '../../center/notifications/data/notifications_api_provider.dart';
import '../../center/notifications/data/notifications_repository.dart';
import '../../center/notifications/presentation/controllers/notifications_controller.dart';
import '../../center/profile/data/profile_api_provider.dart';
import '../../center/profile/data/profile_repository.dart';
import '../../center/profile/presentation/controllers/profile_controller.dart';
import '../../center/search/data/search_api_provider.dart';
import '../../center/search/data/search_repository.dart';
import '../../center/search/presentation/controllers/search_controller.dart';
import '../../parent/blog_parent/data/blog_parent_api_provider.dart';
import '../../parent/blog_parent/data/blog_parent_repository.dart';
import '../../parent/blog_parent/presentation/controllers/blog_parent_controller.dart';
import '../../parent/control_panel_parent/data/control_panel_parent_api_provider.dart';
import '../../parent/control_panel_parent/data/control_panel_parent_repository.dart';
import '../../parent/control_panel_parent/presentation/controllers/control_panel_parent_controller.dart';
import '../../parent/home_parent/data/home_parent_api_provider.dart';
import '../../parent/home_parent/data/home_parent_repository.dart';
import '../../parent/home_parent/presentation/controllers/home_parent_controller.dart';
import '../../parent/notifications_parent/data/notifications_parent_api_provider.dart';
import '../../parent/notifications_parent/data/notifications_parent_repository.dart';
import '../../parent/notifications_parent/presentation/controllers/notifications_parent_controller.dart';
import '../../parent/profile_parent/data/profile_parent_api_provider.dart';
import '../../parent/profile_parent/data/profile_parent_repository.dart';
import '../../parent/profile_parent/presentation/controllers/profile_parent_controller.dart';
import '../../parent/search_parent/data/search_parent_api_provider.dart';
import '../../parent/search_parent/data/search_parent_repository.dart';
import '../../parent/search_parent/presentation/controllers/search_parent_controller.dart';
import '../controller/main_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      MainController(),
    );

    if (AuthService.to.userInfo?.user?.role == "parent") {
      Get.put<IControlPanelParentProvider>(ControlPanelParentProvider());
      Get.put<IControlPanelParentRepository>(
          ControlPanelParentRepository(provider: Get.find()));
      Get.put(ControlPanelParentController(
          controlPanelParentRepository: Get.find()));

      // Get.put<INotificationsParentProvider>(NotificationsParentProvider());
      // Get.put<INotificationsParentRepository>(
      //     NotificationsParentRepository(provider: Get.find()));
      // Get.put(NotificationsParentScreenController(
      //     notificationsParentRepository: Get.find()));

      Get.put<IHomeParentProvider>(HomeParentProvider());
      Get.put<IHomeParentRepository>(
          HomeParentRepository(provider: Get.find()));
      Get.put(HomeParentController(homeParentRepository: Get.find()));

      Get.put<IBlogParentProvider>(BlogParentProvider());
      Get.put<IBlogParentRepository>(
          BlogParentRepository(provider: Get.find()));
      Get.put(BlogParentScreenController(blogParentRepository: Get.find()));

      Get.put<IProfileParentProvider>(ProfileParentProvider());
      Get.put<IProfileParentRepository>(
          ProfileParentRepository(provider: Get.find()));
      Get.put(ProfileParentController(profileParentRepository: Get.find()));
    } else {
      Get.put<IControlPanelProvider>(ControlPanelProvider());
      Get.put<IControlPanelRepository>(
          ControlPanelRepository(provider: Get.find()));
      Get.lazyPut<ControlPanelController>(
        () => ControlPanelController(controlPanelRepository: Get.find()),
        fenix: true,
      );

      // Get.put<INotificationsProvider>(NotificationsProvider());
      // Get.put<INotificationsRepository>(
      //     NotificationsRepository(provider: Get.find()));
      // Get.put(
      //     NotificationsScreenController(notificationsRepository: Get.find()));

      Get.put<IHomeProvider>(HomeProvider());
      Get.put<IHomeRepository>(HomeRepository(provider: Get.find()));
      Get.put(HomeController(homeRepository: Get.find()));

      Get.put<IBlogProvider>(BlogProvider());
      Get.put<IBlogRepository>(BlogRepository(provider: Get.find()));
      Get.put(BlogScreenController(blogRepository: Get.find()));

      Get.put<IProfileProvider>(ProfileProvider());
      Get.put<IProfileRepository>(ProfileRepository(provider: Get.find()));
      Get.put(ProfileController(profileRepository: Get.find()));
    }
  }
}

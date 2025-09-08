import 'package:get/get.dart';

import '../data/notifications_parent_api_provider.dart';
import '../data/notifications_parent_repository.dart';
import '../presentation/controllers/notifications_parent_controller.dart';

class NotificationsParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<INotificationsParentProvider>(NotificationsParentProvider());
    Get.put<INotificationsParentRepository>(NotificationsParentRepository(provider: Get.find()));
    Get.put(NotificationsParentScreenController(notificationsParentRepository: Get.find()));


  }
}

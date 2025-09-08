import 'package:get/get.dart';

import '../data/notifications_api_provider.dart';
import '../data/notifications_repository.dart';
import '../presentation/controllers/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<INotificationsProvider>(NotificationsProvider());
    Get.put<INotificationsRepository>(NotificationsRepository(provider: Get.find()));
    Get.put(NotificationsScreenController(notificationsRepository: Get.find()));
  }
}

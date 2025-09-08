import 'package:get/get.dart';

import '../data/child_reservations_api_provider.dart';
import '../data/child_reservations_repository.dart';
import '../presentation/controller/child_reservations_controller.dart';

class ChildReservationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IChildReservationsProvider>(ChildReservationsProvider());
    Get.put<IChildReservationsRepository>(ChildReservationsRepository(provider: Get.find()));
    Get.put(ChildReservationsController(childReservationsRepository: Get.find()));
  }
}

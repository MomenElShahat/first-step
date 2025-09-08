import 'package:get/get.dart';

import '../data/booking_api_provider.dart';
import '../data/booking_repository.dart';
import '../presentation/controller/booking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IBookingProvider>(BookingProvider());
    Get.put<IBookingRepository>(BookingRepository(provider: Get.find()));
    Get.put(BookingController(bookingRepository: Get.find()));
  }
}

import 'package:get/get.dart';

import '../data/booking_details_api_provider.dart';
import '../data/booking_details_repository.dart';
import '../presentation/controller/booking_details_controller.dart';

class BookingDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IBookingDetailsProvider>(BookingDetailsProvider());
    Get.put<IBookingDetailsRepository>(BookingDetailsRepository(provider: Get.find()));
    Get.put(BookingDetailsController(bookingDetailsRepository: Get.find()));
  }
}

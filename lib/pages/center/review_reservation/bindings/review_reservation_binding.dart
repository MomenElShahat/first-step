import 'package:get/get.dart';
import 'package:first_step/pages/center/review_reservation/data/review_reservation_repository.dart';
import 'package:first_step/pages/center/review_reservation/presentation/controller/review_reservation_controller.dart';

import '../data/review_reservation_api_provider.dart';

class ReviewReservationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IReviewReservationProvider>(ReviewReservationProvider());
    Get.put<IReviewReservationRepository>(ReviewReservationRepository(provider: Get.find()));
    Get.put(ReviewReservationController(reviewReservationRepository: Get.find()));
  }
}

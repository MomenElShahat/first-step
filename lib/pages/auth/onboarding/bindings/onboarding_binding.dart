import 'package:get/get.dart';

import '../data/onboarding_api_provider.dart';
import '../data/onboarding_repository.dart';
import '../presentation/controllers/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IOnboardingProvider>(OnboardingProvider());
    Get.put<IOnboardingRepository>(OnboardingRepository(provider: Get.find()));
    Get.put(OnboardingController(onboardingRepository: Get.find()));


  }
}

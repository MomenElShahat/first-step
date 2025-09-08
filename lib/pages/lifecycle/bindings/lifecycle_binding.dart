import 'package:get/get.dart';
import 'package:first_step/pages/lifecycle/data/lifecycle_api_provider.dart';
import 'package:first_step/pages/lifecycle/data/lifecycle_repository.dart';
import 'package:first_step/pages/lifecycle/presentation/controller/lifecycle_controller.dart';

class LifecycleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ILifecycleProvider>(LifecycleProvider());
    Get.put<ILifecycleRepository>(LifecycleRepository(provider: Get.find()));
    Get.put(LifecycleController(lifecycleRepository: Get.find()));
  }
}

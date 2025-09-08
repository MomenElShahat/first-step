import 'package:get/get.dart';
import '../data/branch_add_api_provider.dart';
import '../data/branch_add_repository.dart';
import '../presentation/controllers/branch_add_controller.dart';

class BranchAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IBranchAddProvider>(BranchAddProvider());
    Get.put<IBranchAddRepository>(BranchAddRepository(provider: Get.find()));
    Get.put(BranchAddScreenController(branchAddRepository: Get.find()));
  }
}

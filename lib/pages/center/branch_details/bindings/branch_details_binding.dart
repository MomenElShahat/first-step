import 'package:first_step/pages/center/branch_details/data/branch_details_repository.dart';
import 'package:first_step/pages/center/branch_details/presentation/controllers/branch_details_controller.dart';
import 'package:get/get.dart';
import '../data/branch_details_api_provider.dart';

class BranchDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IBranchDetailsProvider>(BranchDetailsProvider());
    Get.put<IBranchDetailsRepository>(BranchDetailsRepository(provider: Get.find()));
    Get.put(BranchDetailsScreenController(branchDetailsRepository: Get.find()));
  }
}

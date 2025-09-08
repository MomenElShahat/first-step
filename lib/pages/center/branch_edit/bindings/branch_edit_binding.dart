import 'package:first_step/pages/center/branch_details/data/branch_details_repository.dart';
import 'package:first_step/pages/center/branch_details/presentation/controllers/branch_details_controller.dart';
import 'package:get/get.dart';

import '../data/branch_edit_api_provider.dart';
import '../data/branch_edit_repository.dart';
import '../presentation/controllers/branch_edit_controller.dart';

class BranchEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IBranchEditProvider>(BranchEditProvider());
    Get.put<IBranchEditRepository>(BranchEditRepository(provider: Get.find()));
    Get.put(BranchEditScreenController(branchEditRepository: Get.find()));
  }
}

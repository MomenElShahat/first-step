import 'package:get/get.dart';

import '../data/add_member_api_provider.dart';
import '../data/add_member_repository.dart';
import '../presentation/controllers/add_member_controller.dart';

class AddMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IAddMemberProvider>(AddMemberProvider());
    Get.put<IAddMemberRepository>(AddMemberRepository(provider: Get.find()));
    Get.put(AddMemberScreenController(addMemberRepository: Get.find()));
  }
}

import 'package:get/get.dart';

import '../data/edit_member_api_provider.dart';
import '../data/edit_member_repository.dart';
import '../presentation/controllers/edit_member_controller.dart';

class EditMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IEditMemberProvider>(EditMemberProvider());
    Get.put<IEditMemberRepository>(EditMemberRepository(provider: Get.find()));
    Get.put(EditMemberScreenController(editMemberRepository: Get.find()));
  }
}

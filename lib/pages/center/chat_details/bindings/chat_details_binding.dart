import 'package:get/get.dart';

import '../data/chat_details_api_provider.dart';
import '../data/chat_details_repository.dart';
import '../presentation/controllers/chat_details_controller.dart';

class ChatDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IChatDetailsProvider>(ChatDetailsProvider());
    Get.put<IChatDetailsRepository>(ChatDetailsRepository(provider: Get.find()));
    Get.put(ChatDetailsScreenController(chatDetailsRepository: Get.find()));
  }
}

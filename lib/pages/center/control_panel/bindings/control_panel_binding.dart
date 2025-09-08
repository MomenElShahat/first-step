import 'package:get/get.dart';

import '../data/control_panel_api_provider.dart';
import '../data/control_panel_repository.dart';
import '../presentation/controllers/control_panel_controller.dart';

class ControlPanelBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IControlPanelProvider>(ControlPanelProvider());
    Get.put<IControlPanelRepository>(ControlPanelRepository(provider: Get.find()));
    Get.put(ControlPanelController(controlPanelRepository: Get.find()));


  }
}

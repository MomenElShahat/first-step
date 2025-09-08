import 'package:get/get.dart';

import '../data/control_panel_parent_api_provider.dart';
import '../data/control_panel_parent_repository.dart';
import '../presentation/controllers/control_panel_parent_controller.dart';

class ControlPanelParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<IControlPanelParentProvider>(ControlPanelParentProvider());
    Get.put<IControlPanelParentRepository>(ControlPanelParentRepository(provider: Get.find()));
    Get.put(ControlPanelParentController(controlPanelParentRepository: Get.find()));


  }
}

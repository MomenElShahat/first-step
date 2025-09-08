import 'package:first_step/pages/auth/type_selection/presentation/controllers/type_selection_controller.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageDropdown extends GetView<TypeSelectionController> {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: controller.selectedLanguage,
      onChanged: (String? newValue) {
        if (newValue != null) {
          controller.selectedLanguage = newValue;
          AuthService.to.selectLanguage(controller.selectedLanguage);
          controller.update();
          // Handle language change logic (Use GetX/Provider if needed)
          print("Selected Language: $newValue");
        }
      },
      icon: AppSVGAssets.getWidget(AppSVGAssets.arrowDownLine,width: 12,height: 12), // Downward arrow
      underline: const SizedBox(), // Remove underline
      items: controller.languages.map((lang) {
        return DropdownMenuItem<String>(
          value: lang["code"],
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 10),
            child: Image(image: lang["flag"],width: 24,height: 24,),
          ), // Show flag only
        );
      }).toList(),
    );
  }
}


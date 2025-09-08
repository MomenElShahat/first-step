import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/parent/home_parent/presentation/controllers/home_parent_controller.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:first_step/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../resources/strings_generated.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../../center/auth/signup/models/cities_model.dart';
import '../../controllers/search_parent_controller.dart';

class CitiesDialogSearch extends GetView<SearchParentScreenController> {
  final List<City> cities;

  const CitiesDialogSearch({super.key, required this.cities});

  @override
  Widget build(BuildContext context) {
    void resetSelection() {
      controller.selectedCityIds.clear();
      controller.update();
    }

    void toggleCity(String id) {
      if (controller.selectedCityIds.contains(id)) {
        controller.selectedCityIds.remove(id);
        controller.update();
      } else {
        controller.selectedCityIds.add(id);
        controller.update();
      }
    }

    return Dialog(
      backgroundColor: ColorCode.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Title Row with Reset Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  AppStrings.selectCitiesYouWant,
                  textStyle: TextStyles.body16Medium,
                ),
                IconButton(
                  onPressed: resetSelection,
                  icon: const Icon(Icons.refresh),
                  tooltip: "Reset Selection",
                ),
              ],
            ),
            Gaps.vGap12,

            /// Cities List
            GetBuilder<HomeParentController>(builder: (controller) {
              return SizedBox(
                height: 300.h,
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final city = cities[index];
                    final isSelected = controller.selectedCityIds.contains(city.id.toString());

                    return ListTile(
                      title: CustomText(AuthService.to.language == "en"
                          ? city.name?.en ?? ""
                          : city.name?.ar ?? "",textAlign: TextAlign.start,),
                      trailing: GestureDetector(
                        onTap: () => toggleCity(city.id!.toString()),
                        child: isSelected
                            ? AppSVGAssets.getWidget(AppSVGAssets.checkboxFill)
                            : AppSVGAssets.getWidget(AppSVGAssets.checkbox),
                      ),
                      onTap: () => toggleCity(city.id!.toString()),
                    );
                  },
                ),
              );
            }),
            Gaps.vGap16,
            CustomButton(
                child: CustomText(
                  AppStrings.confirm,
                  textStyle:
                      TextStyles.body16Medium.copyWith(color: ColorCode.white),
                ),
                onPressed: () async{
                  Get.back(result: controller.selectedCityIds);
                  await controller.getCentersWithFilter();
                }),
          ],
        ),
      ),
    );
  }
}

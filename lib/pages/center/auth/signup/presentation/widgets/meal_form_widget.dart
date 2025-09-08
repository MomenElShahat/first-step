import 'package:flutter/material.dart';

import '../../../../../../resources/strings_generated.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/gaps.dart';
import '../../../../control_panel/models/branch_model.dart';
import '../../models/signup_request_model.dart';

class MealFormWidget extends StatefulWidget {
  final FirstMeals meal;
  final ValueChanged<FirstMeals> onChanged;

  const MealFormWidget({super.key, required this.meal, required this.onChanged});

  @override
  State<MealFormWidget> createState() => _MealFormWidgetState();
}

class _MealFormWidgetState extends State<MealFormWidget> {
  late TextEditingController nameController;
  late TextEditingController componentsController;
  late TextEditingController drinksController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.meal.mealName);
    componentsController = TextEditingController(text: widget.meal.components);
    drinksController = TextEditingController(text: widget.meal.juice);
  }

  @override
  void dispose() {
    nameController.dispose();
    componentsController.dispose();
    drinksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CustomTextFormField(
            hint: AppStrings.mealName,
            controller: nameController,
            onChange: (val) {
              widget.onChanged(FirstMeals(
                mealName: val ?? "",
                components: componentsController.text,
                juice: drinksController.text,
              ));
            },
            inputType: TextInputType.text,
            label: '',
          ),
          Gaps.vGap8,
          CustomTextFormField(
            hint: AppStrings.theComponents,
            controller: componentsController,
            onChange: (val) {
              widget.onChanged(FirstMeals(
                mealName: nameController.text,
                components: val ?? "",
                juice: drinksController.text,
              ));
            },
            inputType: TextInputType.text,
            label: '',
          ),
          Gaps.vGap8,
          CustomTextFormField(
            hint: AppStrings.drinks,
            controller: drinksController,
            onChange: (val) {
              widget.onChanged(FirstMeals(
                mealName: nameController.text,
                components: componentsController.text,
                juice: val ?? "",
              ));
            },
            inputType: TextInputType.text,
            label: '',
          ),
          Gaps.vGap16,
        ],
      ),
    );
  }
}


import 'dart:io';
import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/pages/center/control_panel/models/team_member_model.dart';
import 'package:first_step/pages/center/control_panel/presentation/controllers/control_panel_controller.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/widgets/custom_text.dart';
import 'package:first_step/widgets/custom_text_form_field.dart';
import 'package:first_step/widgets/gaps.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ServicesSection extends StatefulWidget {
  final ControlPanelController controller;

  const ServicesSection({super.key, required this.controller});

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
  final ImagePicker _picker = ImagePicker();

  void _initializeControllers() {
    widget.controller.nameServiceControllers.value = widget.controller.services.map((member) => TextEditingController(text: member.name)).toList();

    widget.controller.descServiceControllers.value =
        widget.controller.services.map((member) => TextEditingController(text: member.profession)).toList();

    widget.controller.imageServiceControllers.value = widget.controller.services
        .map((member) => TextEditingController(
            text: member.imageUrl != null
                ? member.imageUrl is File
                    ? path.basename(member.imageUrl!.path)
                    : member.imageUrl is String
                        ? member.imageUrl.split("/").last
                        : ""
                : ''))
        .toList();
  }

  Future<void> _pickImage(int index) async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final file = File(picked.path);
      widget.controller.services[index].imageUrl = file;
      widget.controller.imageServiceControllers[index].value = TextEditingValue(
        text: path.basename(file.path),
        selection: TextSelection.collapsed(offset: path.basename(file.path).length),
      );
      // setState(() {}); // Trigger UI refresh
    }
  }

  @override
  void initState() {
    _initializeControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(widget.controller.services.length, (index) {
          final member = widget.controller.services[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                _buildTextField(
                  label: AppStrings.serviceName,
                  hint: AppStrings.egTeachingTheElementsOfNature,
                  controller: widget.controller.nameServiceControllers[index],
                  onChanged: (val) => member.name = val!,
                ),
                _buildTextField(
                  label: AppStrings.serviceDesc,
                  hint: AppStrings.suchAsServiceContentAndExplanation,
                  controller: widget.controller.descServiceControllers[index],
                  onChanged: (val) => member.profession = val!,
                ),
                const SizedBox(height: 10),
                _buildImagePickerField(index, member.imageUrl),
                if (index > 0)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: AppSVGAssets.getWidget(AppSVGAssets.delete),
                      onPressed: () {
                        setState(() {
                          widget.controller.services.removeAt(index);
                          widget.controller.nameServiceControllers.removeAt(index);
                          widget.controller.descServiceControllers.removeAt(index);
                          widget.controller.imageServiceControllers.removeAt(index);
                          _initializeControllers();
                        });
                      },
                    ),
                  ),
              ],
            ),
          );
        }),
        TextButton.icon(
          onPressed: () {
            setState(() {
              widget.controller.services.add(TeamMemberModel());
              widget.controller.nameServiceControllers.add(TextEditingController());
              widget.controller.descServiceControllers.add(TextEditingController());
              widget.controller.imageServiceControllers.add(TextEditingController());
              _initializeControllers();
            });
          },
          icon: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: CustomText(
              AppStrings.addService,
              textStyle: TextStyles.body14Medium.copyWith(
                color: ColorCode.primary600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          label: AppSVGAssets.getWidget(AppSVGAssets.plusLine, color: ColorCode.primary600, width: 16, height: 16),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required void Function(String?)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          label,
          textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500),
        ),
        Gaps.vGap4,
        CustomTextFormField(
          hint: hint,
          onChange: onChanged,
          controller: controller,
          inputType: TextInputType.text,
          validator: (p0) => null,
          label: "",
        ),
      ],
    );
  }

  Widget _buildImagePickerField(int index, dynamic imageFile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          AppStrings.serviceImage,
          textStyle: TextStyles.body14Regular.copyWith(color: ColorCode.neutral500),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () => _pickImage(index),
          child: AbsorbPointer(
            child: CustomTextFormField(
              hint: "URL",
              enable: false,
              readOnly: true,
              validator: (p0) => null,
              suffixIcon: AppSVGAssets.getWidget(AppSVGAssets.attachLine, color: ColorCode.neutral400),
              controller: widget.controller.imageServiceControllers.value[index],
              inputType: TextInputType.text,
              label: "",
            ),
          ),
        ),
      ],
    );
  }
}

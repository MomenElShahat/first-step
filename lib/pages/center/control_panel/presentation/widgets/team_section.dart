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

class TeamSection extends StatefulWidget {
  final ControlPanelController controller;

  const TeamSection({super.key, required this.controller});

  @override
  State<TeamSection> createState() => _TeamSectionState();
}

class _TeamSectionState extends State<TeamSection> {
  final ImagePicker _picker = ImagePicker();

  void _initializeControllers() {
    widget.controller.nameControllers.value = widget.controller.members
        .map((member) => TextEditingController(text: member.name))
        .toList();

    widget.controller.professionControllers.value = widget.controller.members
        .map((member) => TextEditingController(text: member.profession))
        .toList();

    widget.controller.imageControllers.value = widget.controller.members
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
      widget.controller.members[index].imageUrl = file;
      widget.controller.imageControllers[index].value = TextEditingValue(
        text: path.basename(file.path),
        selection:
            TextSelection.collapsed(offset: path.basename(file.path).length),
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
        ...List.generate(widget.controller.members.length, (index) {
          final member = widget.controller.members[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                _buildTextField(
                  label: AppStrings.theNameOfThePerson,
                  hint: AppStrings.egRahafAmir,
                  controller: widget.controller.nameControllers[index],
                  onChanged: (val) => member.name = val!,
                ),
                _buildTextField(
                  label: AppStrings.aPersonProfession,
                  hint: AppStrings.egNanny,
                  controller: widget.controller.professionControllers[index],
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
                          widget.controller.members.removeAt(index);
                          widget.controller.nameControllers.removeAt(index);
                          widget.controller.professionControllers
                              .removeAt(index);
                          widget.controller.imageControllers.removeAt(index);
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
              widget.controller.members.add(TeamMemberModel());
              widget.controller.nameControllers.add(TextEditingController());
              widget.controller.professionControllers
                  .add(TextEditingController());
              widget.controller.imageControllers.add(TextEditingController());
              _initializeControllers();
            });
          },
          icon: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: CustomText(
              AppStrings.addMember,
              textStyle: TextStyles.body14Medium.copyWith(
                color: ColorCode.primary600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          label: AppSVGAssets.getWidget(AppSVGAssets.plusLine,
              color: ColorCode.primary600, width: 16, height: 16),
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
          textStyle:
              TextStyles.body14Regular.copyWith(color: ColorCode.neutral500),
        ),
        Gaps.vGap4,
        CustomTextFormField(
          hint: hint,
          onChange: onChanged,
          controller: controller,
          inputType: TextInputType.text,
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
          AppStrings.personPicture,
          textStyle:
              TextStyles.body14Regular.copyWith(color: ColorCode.neutral500),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () => _pickImage(index),
          child: AbsorbPointer(
            child: CustomTextFormField(
              hint: AppStrings.personPicture,
              enable: false,
              readOnly: true,
              suffixIcon: AppSVGAssets.getWidget(AppSVGAssets.attachLine,
                  color: ColorCode.neutral400),
              controller: widget.controller.imageControllers[index],
              inputType: TextInputType.text,
              label: "",
            ),
          ),
        ),
      ],
    );
  }
}

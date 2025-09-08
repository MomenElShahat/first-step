import 'dart:io';
import 'package:first_step/consts/colors.dart';
import 'package:first_step/pages/center/branch_add/presentation/controllers/branch_add_controller.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CirclePhotoPickerBranch extends GetView<BranchAddScreenController> {
  const CirclePhotoPickerBranch({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: controller.pickImage,
        borderRadius: BorderRadius.circular(100),
        child: Stack(
          children: [
            GetBuilder<BranchAddScreenController>(builder: (controller) {
              return CircleAvatar(
                radius: 50,
                backgroundImage: controller.logo != null
                    ? FileImage(controller.logo!)
                    : AppAssets.center as ImageProvider,
                backgroundColor: ColorCode.neutral400,
              );
            }),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


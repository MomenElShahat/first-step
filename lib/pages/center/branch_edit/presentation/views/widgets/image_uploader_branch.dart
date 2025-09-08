import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_step/consts/colors.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/branch_edit_controller.dart';

class CirclePhotoPickerBranchEdit extends GetView<BranchEditScreenController> {
  const CirclePhotoPickerBranchEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: controller.pickImage,
        borderRadius: BorderRadius.circular(100),
        child: Stack(
          children: [
            GetBuilder<BranchEditScreenController>(builder: (controller) {
              return CircleAvatar(
                radius: 50,
                backgroundImage: controller.logo != null
                    ? FileImage(controller.logo!)
                    : controller.branch?.logo != null ||
                            (controller.branch?.logo?.isNotEmpty ?? false)
                        ? null
                        : AppAssets.center as ImageProvider,
                backgroundColor: ColorCode.neutral400,
                child: (controller.branch?.logo != null ||
                        (controller.branch?.logo?.isNotEmpty ?? false)) && controller.logo == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50.r),
                        child: CachedNetworkImage(
                          imageUrl: controller.branch?.logo ?? "",
                          fit: BoxFit.fill,
                          placeholder: (context, url) => AspectRatio(
                            aspectRatio: 1,
                            child: Container(color: Colors.grey.shade200),
                          ),
                          errorWidget: (context, url, error) => AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.error),
                            ),
                          ),
                        ),
                      )
                    : null,
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

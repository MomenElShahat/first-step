import 'dart:io';
import 'package:first_step/pages/center/chat_details/presentation/views/widgets/image_viewer.dart';
import 'package:first_step/pages/center/chat_details/presentation/views/widgets/video_viewer.dart';
import 'package:first_step/resources/strings_generated.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:first_step/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../controllers/chat_details_controller.dart';
import "package:video_thumbnail/video_thumbnail.dart";

class ChatDetailsScreen extends GetView<ChatDetailsScreenController> {
  const ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: controller.obx(
        (state) => Column(
          children: [
            Gaps.vGap40,
            _buildHeader(),
            const Divider(color: ColorCode.primary600),
            Expanded(child: _buildMessageList()),

            // Uploading indicator
            GetBuilder<ChatDetailsScreenController>(
              builder: (controller) {
                if (controller.isSending &&
                    (controller.pickedFiles.isNotEmpty)) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ColorCode.primary600,
                          ),
                          SizedBox(width: 10),
                          CustomText("Uploading...")
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            // Preview selected image or video before sending
            GetBuilder<ChatDetailsScreenController>(
              builder: (controller) {
                if (controller.selectedImage != null) {
                  return _buildPreviewImage(controller);
                } else if (controller.selectedVideo != null) {
                  return _buildPreviewVideo(controller);
                }
                return const SizedBox.shrink();
              },
            ),

            _buildInputSection(context)
          ],
        ),
        onLoading: const Center(
          child: SpinKitCircle(
            color: ColorCode.primary600,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 16),
          child: Row(children: [
            Stack(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: AlignmentDirectional(-1.0, -1.0),
                      end: AlignmentDirectional(1.0, 1.0),
                      colors: [
                        Color(0xFF83CBAA),
                        Color(0xFFE3FFF2),
                      ],
                      transform: GradientRotation(
                          50.81 * 3.1416 / 180), // Convert degrees to radians
                    ),
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Center(
                        child: CustomText(
                            controller.getFirstTwoCapitalLetters(
                                controller.name ?? ""),
                            textStyle: TextStyles.subtitle20Medium.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorCode.white))),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(34, 34, 34, 0.12),
                        Color.fromRGBO(34, 34, 34, 0.12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Gaps.hGap8,
            CustomText(controller.name ?? "",
                textStyle: TextStyles.button12.copyWith(
                    fontWeight: FontWeight.w700,
                    color: ColorCode.primary600,
                    height: 1.5)),
          ]),
        ),
        IconButton(
          icon:
              const Icon(Icons.arrow_forward_ios, color: ColorCode.primary600),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }

  Widget _buildMessageList() {
    return GetBuilder<ChatDetailsScreenController>(
      builder: (ctrl) => ListView.builder(
        controller: ctrl.scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: ctrl.messages?.length ?? 0,
        itemBuilder: (_, i) {
          final message = ctrl.messages![i];
          final isSender = message.senderId.toString() ==
              AuthService.to.userInfo?.user?.id.toString();

          return Align(
            alignment: isSender
                ? AlignmentDirectional.centerStart
                : AlignmentDirectional.centerEnd,
            child: Column(
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: isSender
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isSender) ...[
                      const Image(image: AppAssets.avatar),
                      Gaps.hGap4,
                    ],
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          gradient: isSender
                              ? const LinearGradient(
                                  begin: Alignment(-0.15, -1.0),
                                  end: Alignment(1.0, 1.0),
                                  colors: [
                                    Color(0xFF7A8CFD),
                                    Color(0xFF404FB1),
                                    Color(0xFF2B3990),
                                  ],
                                  stops: [0.1117, 0.6374, 0.9471],
                                )
                              : null,
                          color: isSender ? null : ColorCode.white,
                          borderRadius: BorderRadius.circular(8),
                          border: isSender
                              ? null
                              : Border.all(color: ColorCode.primary600)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (message.message?.isNotEmpty ?? false)
                            Text(
                              message.message!,
                              style: TextStyle(
                                color: isSender ? Colors.white : Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                          if (message.imageUrl?.isNotEmpty ?? false)
                            InkWell(
                              onTap: () {
                                Get.to(() => FullScreenMediaViewer(
                                    url: message.imageUrl!));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: CachedImage(
                                  url: message.imageUrl!,
                                  height: 200.h,
                                  width: 200.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          if ((message.videoUrl?.isNotEmpty ?? false))
                            FutureBuilder<String?>(
                              future: VideoThumbnail.thumbnailFile(
                                video: message.videoUrlPath ??
                                    message.videoUrl ??
                                    "",
                                imageFormat: ImageFormat.WEBP,
                                maxWidth: 200, // Customize thumbnail width
                                quality: 75,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        color: isSender
                                            ? ColorCode.white
                                            : ColorCode.primary600,
                                      )),
                                    ),
                                  );
                                } else if (snapshot.hasData &&
                                    snapshot.data != null) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => FullScreenVideoViewer(
                                          videoUrl: message.videoUrlPath ??
                                              message.videoUrl ??
                                              ""));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.file(
                                              File(snapshot.data!),
                                              // Thumbnail file
                                              width: 200.w,
                                              height: 200.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                  Icons.play_circle_fill,
                                                  size: 50,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                        ],
                      ),
                    ),
                    if (!isSender) ...[
                      Gaps.hGap4,
                      Stack(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: AlignmentDirectional(-1.0, -1.0),
                                end: AlignmentDirectional(1.0, 1.0),
                                colors: [
                                  Color(0xFF83CBAA),
                                  Color(0xFFE3FFF2),
                                ],
                                transform: GradientRotation(50.81 *
                                    3.1416 /
                                    180), // Convert degrees to radians
                              ),
                            ),
                            padding: const EdgeInsets.all(0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Center(
                                  child: CustomText(
                                      controller.getFirstTwoCapitalLetters(
                                          controller.name ?? ""),
                                      textStyle: TextStyles.subtitle20Medium
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: ColorCode.white))),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(34, 34, 34, 0.12),
                                  Color.fromRGBO(34, 34, 34, 0.12),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                // if (message.createdAt != null)
                ...[
                  // Gaps.vGap4,
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: 4.0,
                        end: isSender ? 0 : 40,
                        start: isSender ? 40 : 0),
                    child: Text(
                      DateFormat('hh:mm a')
                          .format(DateTime.parse(message.createdAt!)),
                      style: TextStyle(
                        color: isSender ? Colors.white70 : Colors.black45,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPreviewImage(ChatDetailsScreenController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              controller.selectedImage!,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: InkWell(
              onTap: () {
                controller.selectedImage = null;
                controller.pickedFiles.clear();
                controller.update();
              },
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black54,
                child: Icon(Icons.close, size: 16, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPreviewVideo(ChatDetailsScreenController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black12,
            ),
            child: const Center(
              child: Icon(Icons.videocam, size: 50, color: Colors.grey),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: InkWell(
              onTap: () {
                controller.selectedVideo = null;
                controller.pickedFiles.clear();
                controller.update();
              },
              child: const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.black54,
                child: Icon(Icons.close, size: 16, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInputSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: ColorCode.primary600),
          borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.inputController,
              decoration: InputDecoration(
                  hintText: AppStrings.writeYourMessage,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.attach_file,
              color: ColorCode.primary600,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.image,
                            color: ColorCode.primary600,
                            size: 30,
                          ),
                          title: CustomText(
                            AppStrings.pickImage,
                            textStyle: TextStyles.body16Medium,
                            textAlign: TextAlign.start,
                          ),
                          onTap: () {
                            Navigator.pop(context); // Close sheet
                            controller.pickImage();
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.videocam,
                            color: ColorCode.primary600,
                            size: 30,
                          ),
                          title: CustomText(
                            AppStrings.pickVideo,
                            textStyle: TextStyles.body16Medium,
                            textAlign: TextAlign.start,
                          ),
                          onTap: () {
                            Navigator.pop(context); // Close sheet
                            controller.pickVideo();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          // IconButton(
          //   icon: const Icon(Icons.image),
          //   onPressed: controller.pickImage,
          // ),
          // IconButton(
          //   icon: const Icon(Icons.videocam),
          //   onPressed: controller.pickVideo,
          // ),
          controller.isSending
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: ColorCode.primary600),
                )
              : InkWell(
                  onTap: () {
                    if (controller.inputController.text.isNotEmpty &&
                        (controller.selectedVideo != null ||
                        controller.selectedImage != null)) {
                      controller.sendMessages(
                        message: controller.inputController.text,
                        videoUrl: controller.selectedVideo,
                        image: controller.selectedImage,
                      );
                      controller.inputController.clear();
                      controller.selectedImage = null;
                      controller.selectedVideo = null;
                      controller.pickedFiles.clear();
                      controller.update();
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(-1.0, -1.0),
                            end: Alignment(1.0, 1.0),
                            colors: [
                              Color(0xFF7A8CFD), // #7A8CFD at 11.17%
                              Color(0xFF404FB1), // #404FB1 at 63.74%
                              Color(0xFF2B3990), // #2B3990 at 94.71%
                            ],
                            stops: [0.1117, 0.6374, 0.9471],
                          ),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Transform.rotate(
                        angle: AuthService.to.language == "en" ? 3.14 : 0,
                        // rotate 180° if RTL
                        child: const Icon(
                          Icons.send,
                          color: ColorCode.white,
                        ),
                      )),
                ),
        ],
      ),
    );
  }
}

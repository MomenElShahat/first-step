import 'package:first_step/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../../../consts/colors.dart';
import '../../../../../consts/text_styles.dart';
import '../../../../../resources/assets_generated.dart';
import '../../../../../resources/assets_svg_generated.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../services/auth_service.dart';
import '../../../../../widgets/custom_text.dart';
import '../../../../../widgets/gaps.dart';
import '../../models/blogs_model.dart';

class BlogCard extends StatelessWidget {
  final Blogs blog;
  final List<Blogs> blogs;

  const BlogCard({super.key, required this.blog, required this.blogs});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.BLOG_DETAILS_SCREEN, arguments: {"blog": blog, "blogs": blogs});
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.only(right: 12, left: 12, top: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedImage(
                  url: blog.image ?? "",
                  fit: BoxFit.fill,
                  width: 180,
                  height: 80.h,
                  placeHolder: const Image(
                    image: AppAssets.blogPage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Gaps.vGap(6),
              CustomText(
                blog.title is String
                    ? blog.title.toString()
                    : AuthService.to.language == "ar"
                        ? blog.title?.ar ?? ""
                        : blog.title?.en ?? "",
                textAlign: TextAlign.start,
                textStyle: TextStyles.title32Bold.copyWith(fontSize: 12.sp, color: ColorCode.primary600, overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
              Gaps.vGap8,
              CustomText(
                blog.description is String
                    ? blog.description.toString()
                    : AuthService.to.language == "ar"
                        ? blog.description?.ar ?? ""
                        : blog.description?.en ?? "",
                maxLines: 3,
                textAlign: TextAlign.start,
                textStyle: TextStyles.body14Regular.copyWith(fontSize: 6.sp, color: ColorCode.neutral600, overflow: TextOverflow.ellipsis),
              ),
              Gaps.vGap8,
              Row(
                children: [
                  AppSVGAssets.getWidget(AppSVGAssets.calendar),
                  Gaps.hGap4,
                  CustomText(
                    blog.publishedAt ?? "",
                    textStyle: TextStyles.body14Medium.copyWith(fontSize: 8.sp, color: ColorCode.neutral600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

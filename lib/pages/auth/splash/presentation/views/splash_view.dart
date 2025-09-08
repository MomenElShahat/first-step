import 'dart:async';
import 'package:first_step/consts/colors.dart';
import 'package:first_step/consts/text_styles.dart';
import 'package:first_step/routes/app_pages.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:first_step/resources/assets_generated.dart';
import 'package:first_step/resources/assets_svg_generated.dart';
import 'package:get/get.dart';

import '../../../../../widgets/gaps.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _step1Animation;
  late Animation<Offset> _step2Animation;
  late Animation<Offset> _step3Animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Step 1: Bottom Right (Moves to Step 1 position)
    _step1Animation = Tween<Offset>(
      begin: const Offset(2, 1.5), // Start from bottom-right corner
      end: const Offset(.09, -0.04), // Position for Step 1
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Step 2: Top Right (Moves to Step 2 position)
    _step2Animation = Tween<Offset>(
      begin: const Offset(-5, 0.5), // Start from bottom-left corner
      end: const Offset(-0.08, -0.21), // Position for Step 2
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Step 3: Bottom Left (Moves to Step 3 position)
    _step3Animation = Tween<Offset>(
      begin: const Offset(10, -1.5), // Start from top-right corner
      end: const Offset(0.085, -0.39), // Position for Step 3
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _startAnimations();
  }

  void _startAnimations() async {
    // Animate Step 1
    await Future.delayed(const Duration(seconds: 1));
    _controller.forward();

    // Animate Step 2
    await Future.delayed(const Duration(seconds: 2));
    _controller.forward();

    // Animate Step 3
    await Future.delayed(const Duration(seconds: 2));
    _controller.forward();

    // Delay before navigating to next screen
    Future.delayed(const Duration(seconds: 0), () {
      if(AuthService.to.isLoggedIn.value == true){
        if(AuthService.to.userInfo?.user?.role != "branch_admin"){
          Get.offNamed(Routes.BOTTOM_NAVIGATION);
        }else {
          Get.offNamed(Routes.CONTROL_PANEL_SCREEN);
        }

      }else {
        Get.offNamed(Routes.TYPESELECTIONSCREEN);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCode.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: ColorCode.white),
        toolbarHeight: 0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Centered Logo & Text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ScaleTransition(
                //   scale: _fadeAnimation,
                //   child: const Image(
                //     image: AppAssets.logoAnimation, // Your logo SVG asset
                //     // width: 150,
                //     height: 200,
                //   ),
                // ),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    const Image(
                      image: AppAssets.logoAnimation, // Your logo SVG asset
                      // width: 200,
                      // height: 300,
                      fit: BoxFit.fill,
                    ),
                    PositionedDirectional(
                      bottom: -50,
                      child: Column(
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppSVGAssets.getWidget(AppSVGAssets.fVector),
                                  Gaps.hGap4,
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: AppSVGAssets.getWidget(AppSVGAssets.iVector),
                                  ),
                                  Gaps.hGap4,
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: AppSVGAssets.getWidget(AppSVGAssets.rVector),
                                  ),
                                  Gaps.hGap4,
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: AppSVGAssets.getWidget(AppSVGAssets.sVector),
                                  ),
                                  Gaps.hGap4,
                                  AppSVGAssets.getWidget(AppSVGAssets.tVector),
                                  Gaps.hGap20,
                                  AppSVGAssets.getWidget(AppSVGAssets.sCVector),
                                  Gaps.hGap4,
                                  AppSVGAssets.getWidget(AppSVGAssets.tVector),
                                  Gaps.hGap4,
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: AppSVGAssets.getWidget(AppSVGAssets.eVector),
                                  ),
                                  Gaps.hGap4,
                                  Padding(
                                    padding: const EdgeInsets.only(top: 22),
                                    child: AppSVGAssets.getWidget(AppSVGAssets.pVector),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // FadeTransition(
                          //   opacity: _fadeAnimation,
                          //   child: Text(
                          //     "Simplicity is the secret of happiness",
                          //     style: TextStyles.body14Regular.copyWith(color: ColorCode.primary600),
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
                // Gaps.vGap10,
              ],
            ),
          ),
          // Step 1 Animation (Bottom Right)
          // AnimatedBuilder(
          //   animation: _step1Animation,
          //   builder: (context, child) {
          //     return Transform.translate(
          //       offset: _step1Animation.value * MediaQuery.of(context).size.width,
          //       child: Opacity(
          //         opacity: _fadeAnimation.value,
          //         child: AppSVGAssets.getWidget(AppSVGAssets.bottomRightShapeFull,width: 90.w,height: 90.h),
          //       ),
          //     );
          //   },
          // ),
          //
          // // Step 2 Animation (Top Right)
          // AnimatedBuilder(
          //   animation: _step2Animation,
          //   builder: (context, child) {
          //     return Transform.translate(
          //       offset: _step2Animation.value * MediaQuery.of(context).size.width,
          //       child: Opacity(
          //         opacity: _fadeAnimation.value,
          //         child: AppSVGAssets.getWidget(AppSVGAssets.bottomLeftShapeFull),
          //       ),
          //     );
          //   },
          // ),
          //
          // // Step 3 Animation (Bottom Left)
          // AnimatedBuilder(
          //   animation: _step3Animation,
          //   builder: (context, child) {
          //     return Transform.translate(
          //       offset: _step3Animation.value * MediaQuery.of(context).size.width,
          //       child: Opacity(
          //         opacity: _fadeAnimation.value,
          //         child: AppSVGAssets.getWidget(AppSVGAssets.topRightShapeFull),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

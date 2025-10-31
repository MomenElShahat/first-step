import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../resources/assets_generated.dart';

class OnboardingWidget extends StatelessWidget {
  final ImageProvider<Object> image;

  const OnboardingWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: [
        Image(image: AppAssets.layer1),
        PositionedDirectional(top: 37, start: 10, end: 10, child: Image(image: AppAssets.layer2)),
        PositionedDirectional(
            top: image == AppAssets.parentOnboarding1
                ? 90
                : image == AppAssets.centerOnboarding2
                    ? 70
                    : 60,
            bottom: image == AppAssets.centerOnboarding1
                ? -40
                : image == AppAssets.parentOnboarding2
                    ? -10
                    : image == AppAssets.centerOnboarding2
                        ? -26
                        : -33,
            start: image == AppAssets.centerOnboarding1
                ? 40
                : image == AppAssets.centerOnboarding2
                    ? 50
                    : 70,
            end: image == AppAssets.centerOnboarding1 ? 25 : 60,
            child: ClipPath(
                clipper: BottomCurveClipper(image),
                child: Image(
                  image: image,
                  fit: BoxFit.fill,
                ))),
      ],
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  final ImageProvider<Object> image;

  BottomCurveClipper(this.image);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(
        0,
        size.height -
            (image == AppAssets.centerOnboarding1
                ? 50
                : image == AppAssets.centerOnboarding2
                    ? 25
                    : image == AppAssets.parentOnboarding1
                        ? 37
                        : 0)); // left
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height -
          (image == AppAssets.centerOnboarding1
              ? 55
              : image == AppAssets.centerOnboarding2
                  ? 20
                  : image == AppAssets.parentOnboarding1
                      ? 36
                      : 0),
    );
    path.lineTo(size.width, 0); // top-right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

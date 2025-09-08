import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../consts/colors.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final double? height, width, borderWidth;
  final BorderRadius? borderRadius;
  final ColorFilter? colorFilter;
  final Alignment? alignment;
  final Widget? child;
  final Widget? placeHolder;
  final Color? borderColor;
  final Color? bgColor;
  final Color? placeHolderColor;
  final BoxShape? boxShape;
  final bool haveRadius;
  final double? spinSize;

  const CachedImage(
      {Key? key,
      required this.url,
      this.fit,
      this.width,
      this.height,
      this.placeHolder,
      this.borderRadius,
      this.colorFilter,
      this.alignment,
      this.child,
      this.boxShape,
      this.borderColor,
      this.borderWidth,
      this.bgColor,
      this.haveRadius = true,
      this.placeHolderColor,
      this.spinSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: haveRadius ? borderRadius ?? BorderRadius.circular(0) : null,
          border: Border.all(color: borderColor ?? Colors.transparent, width: 0),
          color: bgColor ?? ColorCode.primary600.withOpacity(.5),
          shape: boxShape ?? BoxShape.rectangle,
        ),
        child: Stack(
          children: [
            placeHolder ?? child ?? Container(),
            placeHolder ?? Container(),
          ],
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: fit ?? BoxFit.fill, colorFilter: colorFilter),
          borderRadius: haveRadius ? borderRadius ?? BorderRadius.circular(0) : null,
          shape: boxShape ?? BoxShape.rectangle,
          border: Border.all(color: borderColor ?? Colors.transparent, width: borderWidth ?? 0),
        ),
        alignment: alignment ?? Alignment.center,
        child: child,
      ),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: placeHolderColor,
          borderRadius: haveRadius ? borderRadius ?? BorderRadius.circular(0) : null,
          border: Border.all(color: borderColor ?? Colors.transparent, width: 0),
          shape: boxShape ?? BoxShape.rectangle,
          // color: bgColor ?? ColorCode.primary.withOpacity(.5),
        ),
        child: SpinKitFadingCircle(
          color: ColorCode.primary600,
          size: spinSize ?? 30.0,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor ?? ColorCode.primary600.withOpacity(.5),
          borderRadius: haveRadius ? borderRadius ?? BorderRadius.circular(0) : null,
          border: Border.all(color: borderColor ?? Colors.transparent, width: 0),
          shape: boxShape ?? BoxShape.rectangle,
        ),
        child: Stack(
          children: [
            placeHolder ?? child ?? Container(),
            placeHolder ?? Container(),
          ],
        ),
      ),
    );
  }
}

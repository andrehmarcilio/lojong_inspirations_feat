import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String assetPath;
  final BoxFit? boxFit;

  const SvgWidget({
    required this.assetPath,
    this.width,
    this.height,
    this.boxFit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      fit: boxFit ?? BoxFit.contain,
    );
  }
}

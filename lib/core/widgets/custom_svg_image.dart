import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/theme_controller.dart';

class CustomSvgImage extends StatelessWidget {
  const CustomSvgImage({
    super.key,
    required this.img,
    this.width,
    this.height,
    this.withColorFilter = true,
  });

  // Named Constructor
  const CustomSvgImage.withoutColor({
    super.key,
    required this.img,
    this.width,
    this.height,
  }) : withColorFilter = false;

  final String img;
  final double? width;
  final double? height;
  final bool withColorFilter;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      img,
      width: width,
      height: height,
      fit: BoxFit.cover,
      colorFilter: withColorFilter
          ? ColorFilter.mode(
              Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}

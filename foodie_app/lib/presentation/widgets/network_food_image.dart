import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class NetworkFoodImage extends StatelessWidget {
  const NetworkFoodImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          width: width,
          height: height,
          color: AppColors.primarySoft,
          alignment: Alignment.center,
          child: const SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
      errorBuilder: (_, _, _) => Container(
        width: width,
        height: height,
        color: AppColors.primarySoft,
        alignment: Alignment.center,
        child: const Icon(
          Icons.restaurant_rounded,
          color: AppColors.primary,
          size: 34,
        ),
      ),
    );
  }
}

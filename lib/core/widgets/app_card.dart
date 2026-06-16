import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.radius = AppRadius.medium,
    this.color,
    this.padding,
    this.showShadow = true,
  });

  final Widget child;
  final double radius;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: color ?? AppColors.surface,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: showShadow
          ? const [
              BoxShadow(
                blurRadius: 20,
                color: AppColors.shadow,
                offset: Offset(0, 4),
              ),
            ]
          : null,
    );

    return Container(
      decoration: decoration,
      padding: padding,
      child: child,
    );
  }
}


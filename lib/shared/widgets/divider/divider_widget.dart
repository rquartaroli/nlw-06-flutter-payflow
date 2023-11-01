import 'package:flutter/material.dart';
import 'package:payflow_project/shared/themes/app_colors.dart';

class DividerWidget extends StatelessWidget {
  final double height;
  const DividerWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: height,
      color: AppColors.stroke,
    );
  }
}
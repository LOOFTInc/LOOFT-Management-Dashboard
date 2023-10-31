import 'package:flutter/material.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/presentation/widgets/custom_divider.dart';

class FormDividerWidget extends StatelessWidget {
  /// Custom Form Divider Widget
  const FormDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomDivider(
      thickness: 1,
      opacityColor: OpacityColors.op10,
    );
  }
}

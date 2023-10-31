import 'package:flutter/material.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/presentation/widgets/custom_divider.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class EmailDivider extends StatelessWidget {
  const EmailDivider({super.key});

  @override
  Widget build(BuildContext context) {
    const double spacing = 21;

    return const Row(
      children: [
        Expanded(child: _CustomDivider()),
        SizedBox(width: spacing),
        CustomText(
          'Or with Email',
          opacity: OpacityColors.op40,
        ),
        SizedBox(width: spacing),
        Expanded(child: _CustomDivider()),
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider();

  @override
  Widget build(BuildContext context) {
    return const CustomDivider(
      opacityColor: OpacityColors.op10,
      height: 1,
      thickness: 1,
    );
  }
}

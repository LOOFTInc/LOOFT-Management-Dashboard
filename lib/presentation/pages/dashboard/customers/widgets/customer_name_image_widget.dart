import 'package:flutter/material.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class CustomerNameImageWidget extends StatelessWidget {
  const CustomerNameImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          'Kate Morrison',
          style: K.headingStyleDashboard,
        ),
        const Gap16(),
        Image.asset(
          'assets/images/kate.png',
          height: 75,
          fit: BoxFit.cover,
        ),
        const Gap16(),
        const CustomText(
          'Allowed files types: png, jpg, jpeg.',
          opacity: OpacityColors.op40,
        ),
      ],
    );
  }
}

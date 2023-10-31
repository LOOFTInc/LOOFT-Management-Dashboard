import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants.dart';
import '../../../../helper_functions.dart';
import '../../../widgets/text_widgets/custom_text.dart';

class StatusWidget extends StatelessWidget {
  /// Widget to show the overview status on top of pages
  const StatusWidget({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.backgroundColor,
    this.height,
    this.width,
    this.isMoney = false,
    this.topRightSVGPath,
  });

  /// Title of the status
  final String title;

  /// Value of the status
  final double value;

  /// Percentage of the status
  final double percentage;

  /// Background color of the status container
  final Color backgroundColor;

  /// Height of the status container
  final double? height;

  /// Width of the status container
  final double? width;

  /// Whether the value is money or not
  final bool isMoney;

  /// SVG path of the picture to show in the top right corner
  final String? topRightSVGPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CustomText(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  staticColor: K.black,
                ),
              ),
              if (topRightSVGPath != null)
                SvgPicture.asset(
                  topRightSVGPath!,
                  width: 24,
                  height: 24,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CustomText(
                  '${isMoney ? '\$' : ''}${HelperFunctions.doubleToStringWithQuantifierSuffix(value)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  staticColor: K.black,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    '${HelperFunctions.getSignFromValue(percentage)}${percentage.toStringAsFixed(2)}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    staticColor: K.black,
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    percentage < 0
                        ? 'assets/icons/arrow_fall.svg'
                        : 'assets/icons/arrow_rise.svg',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

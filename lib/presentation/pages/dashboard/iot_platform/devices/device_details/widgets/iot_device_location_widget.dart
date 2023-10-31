import 'package:flutter/material.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/device_details/widgets/show_device_lcoation_map.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/responsive_row.dart';
import 'package:management_dashboard/presentation/widgets/custom_container.dart';
import 'package:management_dashboard/presentation/widgets/custom_divider.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class IoTDeviceLocationWidget extends StatelessWidget {
  /// A widget to display the location of an IoT device
  const IoTDeviceLocationWidget({
    super.key,
    required this.device,
  });

  /// IoT Device to display the location for
  final IoTDevice device;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: _HelperPadding(
              child: CustomText('Location'),
            ),
          ),
          Expanded(
            child: ShowDeviceLocationMap(
              latLng: device.location?.latLng,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _HelperSpacedTextWidget(
                    leftText: 'Address',
                    rightText: device.location?.address ?? '?',
                  ),
                ),
                if (device.location?.tag != null &&
                    (device.location?.tag?.isNotEmpty ?? false))
                  Column(
                    children: [
                      const CustomDivider(
                        opacityColor: OpacityColors.op10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: _HelperSpacedTextWidget(
                          leftText: 'Location Tag',
                          rightText: device.location?.tag ?? '?',
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HelperPadding extends StatelessWidget {
  /// A widget to add padding to its child
  const _HelperPadding({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: child,
    );
  }
}

class _HelperSpacedTextWidget extends StatelessWidget {
  /// A widget to display two texts with a space between them
  const _HelperSpacedTextWidget({
    required this.leftText,
    required this.rightText,
  });

  /// The text to display on the left
  final String leftText;

  /// The text to display on the right
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ResponsiveRow(
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        rightExpanded: true,
        leftWidget: Align(
          alignment: Alignment.centerLeft,
          child: CustomText(leftText),
        ),
        verticalGapWidget: const SizedBox(height: 5),
        rightWidget: Align(
          alignment: Alignment.centerRight,
          child: CustomText(
            rightText,
            textAlign: TextAlign.end,
            opacity: OpacityColors.op40,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
            showTooltip: true,
          ),
        ),
        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
        breakWidth: K.mobileSize,
      ),
    );
  }
}

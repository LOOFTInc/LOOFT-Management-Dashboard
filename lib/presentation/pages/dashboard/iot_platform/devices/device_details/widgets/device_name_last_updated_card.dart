import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/data/models/enums/iot_device_status.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/blocs/iot_devices_list/iot_devices_list_bloc.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/iot_device_status_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/responsive_row.dart';
import 'package:management_dashboard/presentation/widgets/custom_container.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class DeviceNameLastUpdatedCard extends StatelessWidget {
  /// A widget to display the device name and last updated date
  const DeviceNameLastUpdatedCard({
    super.key,
    required this.device,
  });

  /// IoT Device to display the name and last updated date for
  final IoTDevice device;

  @override
  Widget build(BuildContext context) {
    IoTDeviceStatus status = IoTDeviceStatus.offline;
    if (device.lastUpdated != null) {
      status = DateTime.now().difference(device.lastUpdated!).inMinutes < 10
          ? IoTDeviceStatus.online
          : IoTDeviceStatus.offline;
    }

    return CustomContainer(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: ResponsiveRow(
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        leftWidget: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const CustomSvg(svgPath: 'assets/icons/broadcast.svg', size: 20),
            const SizedBox(width: 10),
            Flexible(
              child: CustomText(device.deviceName ?? '?'),
            ),
            const Gap16(isHorizontal: true, changeForMobile: false),
            Flexible(
              child: CustomText(
                device.deviceID,
                style: const TextStyle(fontSize: 12),
                opacity: OpacityColors.op40,
              ),
            ),
            const Gap16(isHorizontal: true, changeForMobile: false),
            IoTDeviceStatusWidget(
              status: status,
            ),
          ],
        ),
        verticalGapWidget: const SizedBox(height: 10),
        rightWidget: Align(
          alignment: Alignment.centerRight,
          child: BlocBuilder<IoTDevicesListBloc, IoTDevicesListState>(
            builder: (context, state) {
              IoTDevice? currentDevice = state.devices
                  .firstWhere((element) => element.deviceID == device.deviceID);

              return CustomText(
                'Last Updated: ${currentDevice.lastUpdated == null ? 'Never' : HelperFunctions.getFormattedDate(currentDevice.lastUpdated!)}',
                textAlign: TextAlign.end,
                opacity: OpacityColors.op40,
              );
            },
          ),
        ),
        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
        breakWidth: K.mobileSize,
      ),
    );
  }
}

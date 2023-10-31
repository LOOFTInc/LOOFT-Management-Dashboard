import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';
import 'package:management_dashboard/logic/cubits/iot_device_management/iot_device_management_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_form_info_card.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/custom_check_box.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class IoTDeviceDeleteCard extends StatefulWidget {
  /// A card to Delete an IoT account
  const IoTDeviceDeleteCard({
    super.key,
    required this.device,
    required this.onDeleted,
  });

  /// IoT Device to delete
  final IoTDevice device;

  /// Callback when the device is deleted
  final VoidCallback onDeleted;

  @override
  State<IoTDeviceDeleteCard> createState() => _IoTDeviceDeleteCardState();
}

class _IoTDeviceDeleteCardState extends State<IoTDeviceDeleteCard> {
  final RxBool confirm = false.obs;

  @override
  Widget build(BuildContext context) {
    return DashboardResponsiveContainer(
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      'Delete Device',
                      style: K.headingStyleDashboard,
                    ),
                    const Gap16(),
                    BlocProvider(
                      create: (context) => IoTDeviceManagementCubit(
                          companyName:
                              BlocProvider.of<AuthenticationCubit>(context)
                                  .state
                                  .company!),
                      child: Builder(
                        builder: (context) => CustomTextButton(
                          text: 'Delete Device',
                          fontSize: 12,
                          backgroundColor: K.redFF4747,
                          textColor: K.white,
                          onPressed: () async {
                            if (!confirm.value) {
                              K.showToast(
                                  message:
                                      'Please confirm to delete the device');
                              return;
                            }

                            String? error =
                                await BlocProvider.of<IoTDeviceManagementCubit>(
                                        context)
                                    .deleteIoTDevice(widget.device);

                            if (error != null) {
                              K.showToast(message: error);
                              return;
                            }

                            K.showToast(message: 'Device deleted successfully');

                            widget.onDeleted();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap16(changeForMobile: false),
                const DashboardFormInfoCard(
                  leading: CustomSvg(
                    svgPath: 'assets/icons/warning_circle.svg',
                  ),
                  headingText: 'You Are Deleting This Device',
                  subTitle: CustomText(
                    'For extra security, this requires you to be an Manager or Admin.',
                    style: TextStyle(fontSize: 12),
                    opacity: OpacityColors.op40,
                  ),
                ),
                const Gap16(),
                Row(
                  children: [
                    Obx(
                      () => CustomCheckBox(
                        value: confirm.value,
                        onChanged: (value) {
                          setState(() {
                            confirm.value = value ?? true;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    const CustomText('I confirm to delete this device'),
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

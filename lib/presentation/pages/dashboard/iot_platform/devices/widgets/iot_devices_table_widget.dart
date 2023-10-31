import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/data/models/enums/iot_device_status.dart';
import 'package:management_dashboard/data/models/extensions/string_extensions.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/blocs/iot_devices_list/iot_devices_list_bloc.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/iot_device_status_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/models/custom_colors.dart';
import 'package:management_dashboard/presentation/pages/dashboard/models/table_column.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/custom_table_column.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/custom_table_separator.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/table_header.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/table_list_tile.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';

class IoTDevicesTableWidget extends StatefulWidget {
  /// IoT Devices Table Widget
  const IoTDevicesTableWidget({
    super.key,
    required this.searchValue,
  });

  /// Value to search in the table
  final String searchValue;

  @override
  State<IoTDevicesTableWidget> createState() => _IoTDevicesTableWidgetState();
}

class _IoTDevicesTableWidgetState extends State<IoTDevicesTableWidget> {
  /// Index of the column on which sorting is applied
  int sortingIndex = -5;

  /// List of columns to be displayed
  final List<TableColumn> columns = [
    TableColumn(title: 'Device Name', flex: 4),
    TableColumn(title: 'MAC Address', flex: 5),
    TableColumn(title: 'Location', flex: 5),
    TableColumn(title: 'Status', flex: 3),
    TableColumn(title: 'Last Updated', flex: 4),
  ];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < columns.length; i++) {
      columns[i].onTap = () {
        setState(() {
          sortingIndex = sortingIndex == -(i + 1) ? (i + 1) : -(i + 1);
        });
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableHeader(
          columns: columns,
          onCheckAll: (val) {},
          sortingIndex: sortingIndex,
        ),
        Expanded(
          child: BlocBuilder<IoTDevicesListBloc, IoTDevicesListState>(
            builder: (context, devicesState) {
              if (devicesState is IoTDevicesListLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (devicesState is IoTDevicesListLoadingFailureState) {
                return Center(
                  child:
                      Text(devicesState.error ?? 'Failed to load IoT Devices'),
                );
              }

              List<IoTDevice> devices = List.from(devicesState.devices);

              // Sorts the devices based on the sorting index
              int tempIndex = sortingIndex.abs() - 1;
              if (sortingIndex.isNegative) {
                devices.sort((a, b) => HelperFunctions.compare(
                    getValueFromIndex(b, tempIndex),
                    getValueFromIndex(a, tempIndex)));
              } else {
                devices.sort((a, b) => HelperFunctions.compare(
                    getValueFromIndex(a, tempIndex),
                    getValueFromIndex(b, tempIndex)));
              }

              // Filters the devices based on the search value
              devices = devices.where((element) {
                for (int i = 0; i < columns.length; i++) {
                  if (getStringValueFromIndex(element, i)
                      .toLowerCase()
                      .contains(widget.searchValue)) {
                    return true;
                  }
                }

                return false;
              }).toList();

              return ListView.separated(
                itemBuilder: (context, index) {
                  if (index == devices.length) {
                    return const Gap28();
                  }

                  return BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, themeState) {
                      final IoTDevice currentDevice = devices[index];

                      return TableListTile(
                        tileColor: currentDevice.deviceName != null
                            ? null
                            : themeState.themeMode == ThemeMode.dark
                                ? CustomColors.lime.darkModeBackgroundColor
                                : CustomColors.lime.lightModeBackgroundColor,
                        onDoubleTap: () {
                          context.goNamed(
                            AppRoutes.iotDeviceDetailsRoute.name,
                            pathParameters: {
                              'deviceID': currentDevice.deviceID,
                            },
                          );
                          return;
                        },
                        onEdit: () {
                          context.goNamed(
                            AppRoutes.editIotDeviceRoute.name,
                            pathParameters: {
                              'deviceID': currentDevice.deviceID,
                            },
                            extra: {
                              'device': currentDevice,
                            },
                          );
                        },
                        content: Row(
                          children: [
                            ...List.generate(columns.length, (subIndex) {
                              if (subIndex == 0) {
                                return Expanded(
                                  flex: columns[subIndex].flex,
                                  child: CustomTableColumn(
                                    text: getStringValueFromIndex(
                                        currentDevice, subIndex),
                                    leading: const CustomSvg(
                                      svgPath: 'assets/icons/broadcast.svg',
                                      size: 16,
                                    ),
                                  ),
                                );
                              }

                              if (subIndex == 3) {
                                IoTDeviceStatus status =
                                    IoTDeviceStatus.offline;
                                if (currentDevice.lastUpdated != null) {
                                  status = DateTime.now()
                                              .difference(
                                                  currentDevice.lastUpdated!)
                                              .inMinutes <
                                          10
                                      ? IoTDeviceStatus.online
                                      : IoTDeviceStatus.offline;
                                }

                                return Expanded(
                                  flex: columns[subIndex].flex,
                                  child: CustomTableColumn(
                                    text: '',
                                    child: IoTDeviceStatusWidget(
                                      status: status,
                                    ),
                                  ),
                                );
                              }

                              if (subIndex == 4) {
                                return Expanded(
                                  flex: columns[subIndex].flex,
                                  child: CustomTableColumn(
                                    text: getStringValueFromIndex(
                                        currentDevice, subIndex),
                                    leading: const CustomSvg(
                                      svgPath: 'assets/icons/calender.svg',
                                      size: 16,
                                    ),
                                  ),
                                );
                              }

                              return Expanded(
                                flex: columns[subIndex].flex,
                                child: CustomTableColumn(
                                  text: getStringValueFromIndex(
                                      currentDevice, subIndex),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    const CustomTableSeparator(),
                itemCount: devices.length + 1,
              );
            },
          ),
        ),
      ],
    );
  }

  /// Returns the String form of value from the index
  String getStringValueFromIndex(IoTDevice iotDevice, int index) {
    if (index == 3) {
      IoTDeviceStatus status = IoTDeviceStatus.offline;
      if (iotDevice.lastUpdated != null) {
        status =
            DateTime.now().difference(iotDevice.lastUpdated!).inMinutes < 10
                ? IoTDeviceStatus.online
                : IoTDeviceStatus.offline;
      }

      return status.name.capitalized;
    } else if (index == 4) {
      if (iotDevice.lastUpdated == null) {
        return '?';
      } else {
        return HelperFunctions.getFormattedLastUpdatedDate(
            iotDevice.lastUpdated!);
      }
    }

    return handleNullValue(getValueFromIndex(iotDevice, index));
  }

  /// Returns the value from the index
  dynamic getValueFromIndex(IoTDevice iotDevice, int index) {
    if (index == 0) {
      return iotDevice.deviceName;
    } else if (index == 1) {
      return iotDevice.deviceID;
    } else if (index == 2) {
      return iotDevice.location?.address;
    } else if (index == 3 || index == 4) {
      return iotDevice.lastUpdated;
    }
  }

  /// Handles null value
  handleNullValue(dynamic value) {
    if (value == null) {
      return '?';
    }
    return value;
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/data/models/classes/iot_device_historical_data.dart';
import 'package:management_dashboard/data/models/classes/iot_device_listener_data.dart';
import 'package:management_dashboard/data/models/extensions/string_list_extensions.dart';
import 'package:management_dashboard/data/repositories/firebase/iot_devices_repository.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';

part 'iot_devices_list_event.dart';
part 'iot_devices_list_state.dart';

/// Bloc for IoT Devices
class IoTDevicesListBloc
    extends Bloc<IoTDevicesListEvent, IoTDevicesListState> {
  IoTDevicesListBloc() : super(IoTDevicesListInitialState()) {
    on<IoTDevicesListEvent>((event, emit) {
      if (event is IoTDevicesListLoadingEvent) {
        emit(IoTDevicesListLoadingState());
      } else if (event is IoTDevicesListUpdateEvent) {
        emit(IoTDevicesListUpdateState(devices: event.devices));
      } else if (event is IoTDevicesListLoadingFailureEvent) {
        emit(IoTDevicesListLoadingFailureState());
      }
    });
  }

  /// Initializes the Bloc
  void initBloc({
    required AuthenticationCubit authenticationCubit,
  }) {
    if (state is IoTDevicesListInitialState ||
        authenticationCubit.state.user?.uid !=
            _authenticationState?.user?.uid) {
      _iotDevicesRepository = IoTDevicesRepository(
        companyName: authenticationCubit.state.company!,
      );
      add(IoTDevicesListLoadingEvent());
      _realtimeDataStreamSubscription?.cancel();
      startRealtimeDataStream();
      _devicesStreamSubscription?.cancel();
      startDevicesDataStream();
    }
  }

  /// Authentication State
  AuthenticationState? _authenticationState;

  /// Returns the device with the given [deviceID]
  IoTDevice? getDeviceFromID(String deviceID) {
    return state.devices
        .firstWhereOrNull((element) => element.deviceID == deviceID);
  }

  /// Updates the Historical Data for a device
  Future<String?> updateHistoricalDataForDevice({
    required String deviceID,
    required DateTimeRange dateRange,
  }) async {
    try {
      final List<Map<String, dynamic>> result = await _iotDevicesRepository
          ?.fetchIoTDevicesHistoricalDataBetweenDates(
        deviceID: deviceID,
        startDate: dateRange.start,
        endDate: dateRange.end,
      ) as List<Map<String, dynamic>>;

      List<IoTDevice> devices = List.from(state.devices);
      devices
          .firstWhere((element) => element.deviceID == deviceID)
          .historicalData = IoTDeviceHistoricalData(
        rawData: result,
        dateRange: dateRange,
      );

      add(IoTDevicesListUpdateEvent(devices: devices));

      return null;
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e);
    }
  }

  /// Toggles a metric for a device
  bool toggleDeviceMetric({
    required String deviceID,
    required String metric,
    required bool isSecondGraph,
  }) {
    List<IoTDevice> devices = List.from(state.devices);
    try {
      IoTDevice device =
          devices.firstWhere((element) => element.deviceID == deviceID);
      if (device.historicalData == null) {
        return false;
      }

      if (isSecondGraph) {
        device.selectedMetrics2 ??= [];
        device.selectedMetrics2 = device.selectedMetrics2?.toggle(metric);
      } else {
        device.selectedMetrics ??= [];
        device.selectedMetrics = device.selectedMetrics?.toggle(metric);
      }
      add(IoTDevicesListUpdateEvent(devices: devices));

      if (device.deviceName != null) {
        _iotDevicesRepository?.addOrUpdateIoTDevice(
          deviceID: device.deviceID,
          data: isSecondGraph
              ? {
                  'selectedMetrics2': device.selectedMetrics2,
                }
              : {
                  'selectedMetrics': device.selectedMetrics,
                },
        );
      }

      if (isSecondGraph) {
        return device.selectedMetrics2?.contains(metric) ?? false;
      } else {
        return device.selectedMetrics?.contains(metric) ?? false;
      }
    } catch (e) {
      return false;
    }
  }

  /// IoT Devices Repository
  IoTDevicesRepository? _iotDevicesRepository;

  /// Realtime Data Stream Subscription
  StreamSubscription? _realtimeDataStreamSubscription;

  /// IoT Devices Stream Subscription
  StreamSubscription? _devicesStreamSubscription;

  /// Start IoT Realtime Data Stream
  void startRealtimeDataStream() {
    _realtimeDataStreamSubscription =
        _iotDevicesRepository?.getIoTRealtimeDataStream().listen(
      (event) {
        final List<IoTDevice> devices = List.from(state.devices);

        for (DocumentChange<Map<String, dynamic>> change in event.docChanges) {
          if (change.type == DocumentChangeType.added ||
              change.type == DocumentChangeType.modified) {
            int indexOfDevice = devices
                .indexWhere((element) => element.deviceID == change.doc.id);

            if (indexOfDevice == -1) {
              devices.add(
                IoTDevice.fromRealtimeData(
                  deviceID: change.doc.id,
                  realtimeData: change.doc.data(),
                ),
              );
              continue;
            }

            if (change.doc.data() != null) {
              devices[indexOfDevice].updateRealtimeData(change.doc.data()!);
            }
          } else if (change.type == DocumentChangeType.removed) {
            int indexOfDevice = devices
                .indexWhere((element) => element.deviceID == change.doc.id);

            if (indexOfDevice != -1 &&
                devices[indexOfDevice].deviceName != null) {
              devices.removeAt(indexOfDevice);
            }
          }
        }

        add(IoTDevicesListUpdateEvent(devices: devices));
      },
      onError: (error) {
        if (error is FirebaseException) {
          add(IoTDevicesListLoadingFailureEvent(
              error: error.message ?? K.unexpectedError));
          return;
        }
        add(IoTDevicesListLoadingFailureEvent(error: error.toString()));
      },
    );
  }

  /// Start IoT Devices Data Stream
  void startDevicesDataStream() {
    _devicesStreamSubscription =
        _iotDevicesRepository?.getIoTDevicesDataStream().listen(
      (event) {
        final List<IoTDevice> devices = List.from(state.devices);

        for (DocumentChange<Map<String, dynamic>> change in event.docChanges) {
          if (change.type == DocumentChangeType.added ||
              change.type == DocumentChangeType.modified) {
            int indexOfDevice = devices
                .indexWhere((element) => element.deviceID == change.doc.id);

            if (indexOfDevice == -1) {
              devices.add(
                IoTDevice(
                  deviceID: change.doc.id,
                )..loadDeviceDataFromFirebaseJson(change.doc.data()!),
              );
              continue;
            }

            if (change.doc.data() != null) {
              devices[indexOfDevice]
                  .loadDeviceDataFromFirebaseJson(change.doc.data()!);
            }
          } else if (change.type == DocumentChangeType.removed) {
            int indexOfDevice = devices
                .indexWhere((element) => element.deviceID == change.doc.id);

            if (indexOfDevice != -1) {
              devices.removeAt(indexOfDevice);
            }
          }
        }

        add(IoTDevicesListUpdateEvent(devices: devices));
      },
      onError: (error) {
        if (error is FirebaseException) {
          add(IoTDevicesListLoadingFailureEvent(
              error: error.message ?? K.unexpectedError));
          return;
        }
        add(IoTDevicesListLoadingFailureEvent(error: error.toString()));
      },
    );
  }

  /// Fetches the IoT Device Listeners from Firebase
  Future<String?> fetchIoTDeviceListeners({required IoTDevice device}) async {
    try {
      final result = await _iotDevicesRepository?.fetchIoTDeviceListeners(
        deviceID: device.deviceID,
      ) as QuerySnapshot;

      final List<IoTDeviceListenerData> listeners = result.docs
          .map((e) => IoTDeviceListenerData.fromFirebaseMap(
                e.data() as Map<String, dynamic>,
                e.id,
              ))
          .toList();

      final List<IoTDevice> devices = List.from(state.devices);
      devices
          .firstWhere((element) => element.deviceID == device.deviceID)
          .listeners = listeners;

      add(IoTDevicesListUpdateEvent(devices: devices));
      return null;
    } catch (e) {
      if (e is FirebaseException) {
        return '${e.message} Please Refresh the Page';
      }

      return 'Unable to load Device Listeners. Please Refresh the Page';
    }
  }

  /// Adds a new IoT Device Listener to Firebase
  Future<String?> addIoTDeviceListener({
    required IoTDevice device,
    required IoTDeviceListenerData listener,
  }) async {
    try {
      List<IoTDeviceListenerData> listeners = device.listeners ?? [];

      return await _iotDevicesRepository
          ?.addIoTDeviceListener(
        deviceID: device.deviceID,
        data: listener.toMap(),
      )
          .then((value) {
        listener.listenerID = value;

        listeners.add(listener);
        final List<IoTDevice> devices = List.from(state.devices);
        devices
            .firstWhere((element) => element.deviceID == device.deviceID)
            .listeners = listeners;
        add(IoTDevicesListUpdateEvent(devices: devices));
        return null;
      });
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e);
    }
  }

  /// Deletes an IoT Device Listener from Firebase
  Future<String?> deleteIoTDeviceListener({
    required IoTDevice device,
    required IoTDeviceListenerData listener,
  }) async {
    try {
      List<IoTDeviceListenerData> listeners = device.listeners ?? [];

      return await _iotDevicesRepository
          ?.deleteIoTDeviceListener(
        deviceID: device.deviceID,
        listenerID: listener.listenerID!,
      )
          .then((value) {
        listeners.remove(listener);
        final List<IoTDevice> devices = List.from(state.devices);
        devices
            .firstWhere((element) => element.deviceID == device.deviceID)
            .listeners = listeners;
        add(IoTDevicesListUpdateEvent(devices: devices));
        return null;
      });
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e);
    }
  }

  /// Updates an IoT Device Listener in Firebase
  Future<String?> updateIoTDeviceListener({
    required IoTDevice device,
    required IoTDeviceListenerData listener,
  }) async {
    try {
      List<IoTDeviceListenerData> listeners = device.listeners ?? [];

      return await _iotDevicesRepository
          ?.updateIoTDeviceListener(
        deviceID: device.deviceID,
        listenerID: listener.listenerID!,
        data: listener.toMap(),
      )
          .then((value) {
        int index = listeners
            .indexWhere((element) => element.listenerID == listener.listenerID);
        listeners[index] = listener;

        final List<IoTDevice> devices = List.from(state.devices);
        devices
            .firstWhere((element) => element.deviceID == device.deviceID)
            .listeners = listeners;
        add(IoTDevicesListUpdateEvent(devices: devices));
        return null;
      });
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e);
    }
  }

  @override
  Future<void> close() {
    _realtimeDataStreamSubscription?.cancel();
    _devicesStreamSubscription?.cancel();

    return super.close();
  }
}

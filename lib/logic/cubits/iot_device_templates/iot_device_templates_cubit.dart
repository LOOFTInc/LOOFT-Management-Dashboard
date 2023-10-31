import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template.dart';
import 'package:management_dashboard/data/repositories/firebase/iot_devices_templates_repository.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';

part 'iot_device_templates_state.dart';

/// Cubit for the [IoTDeviceTemplate]s
class IoTDeviceTemplatesCubit extends Cubit<IoTDeviceTemplatesState> {
  IoTDeviceTemplatesCubit() : super(IoTDeviceTemplatesInitialState());

  /// Initializes the cubit
  void initCubit({
    required AuthenticationCubit authenticationCubit,
  }) {
    if (state is IoTDeviceTemplatesInitialState ||
        authenticationCubit.state.user?.uid !=
            _authenticationState?.user?.uid) {
      _iotDevicesTemplatesRepository = IoTDevicesTemplatesRepository(
        companyName: authenticationCubit.state.company!,
      );

      fetchIoTDeviceTemplates().then((value) {
        if (value != null) {
          K.showToast(message: value);
        }
      });

      fetchDefaultTemplate().then((value) {
        if (value != null) {
          K.showToast(message: value);
        }
      });
    }
  }

  /// Authentication State
  AuthenticationState? _authenticationState;

  /// Repository for the [IoTDeviceTemplate]s
  IoTDevicesTemplatesRepository? _iotDevicesTemplatesRepository;

  /// Returns the template with the given [templateID]
  IoTDeviceTemplate? getTemplateOrDefault(String? templateID) {
    try {
      return state.deviceTemplates
          .firstWhere((element) => element.templateID == templateID);
    } catch (e) {
      try {
        return state.deviceTemplates.firstWhere(
            (element) => element.templateID == state.defaultTemplateID);
      } catch (e) {
        return null;
      }
    }
  }

  /// Fetches the IoT Device Templates from Firebase
  Future<String?> fetchIoTDeviceTemplates() async {
    try {
      final result = await _iotDevicesTemplatesRepository?.fetchIoTTemplates()
          as QuerySnapshot;

      final List<IoTDeviceTemplate> templates = result.docs
          .map((e) => IoTDeviceTemplate.fromFirebaseMap(
                e.data() as Map<String, dynamic>,
                e.id,
              ))
          .toList();

      emit(state.copyWith(deviceTemplates: templates));
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      if (e is FirebaseException) {
        return '${e.message} Please Refresh the Page';
      }

      if (e.toString().contains('permission-denied')) {
        return 'Permission denied';
      }

      return 'Unable to load Device Templates. Please Refresh the Page';
    }
  }

  /// Adds a new IoT Device Template to Firebase
  Future<String?> addIoTDeviceTemplate(IoTDeviceTemplate template) async {
    try {
      List<IoTDeviceTemplate> templates = state.deviceTemplates;

      return await _iotDevicesTemplatesRepository
          ?.addIoTTemplate(
        data: template.toMap(),
      )
          .then((value) {
        template.templateID = value;

        templates.add(template);
        emit(state.copyWith(deviceTemplates: templates));
        return null;
      });
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e);
    }
  }

  /// Deletes an IoT Device Template from Firebase
  Future<String?> deleteIoTDeviceTemplate(IoTDeviceTemplate template) async {
    try {
      List<IoTDeviceTemplate> templates = state.deviceTemplates;

      return await _iotDevicesTemplatesRepository
          ?.deleteIoTTemplate(
        templateID: template.templateID,
      )
          .then((value) async {
        templates.remove(template);
        emit(state.copyWith(deviceTemplates: templates));

        if (state.defaultTemplateID == template.templateID) {
          return await setDefaultTemplate(null);
        }

        return null;
      });
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e);
    }
  }

  /// Updates an IoT Device Template in Firebase
  Future<String?> updateIoTDeviceTemplate(IoTDeviceTemplate template) async {
    try {
      List<IoTDeviceTemplate> templates = state.deviceTemplates;

      return await _iotDevicesTemplatesRepository
          ?.updateIoTTemplate(
        templateID: template.templateID,
        data: template.toMap(),
      )
          .then((value) {
        templates[templates.indexWhere(
            (element) => element.templateID == template.templateID)] = template;
        emit(state.copyWith(deviceTemplates: templates));
        return null;
      });
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e);
    }
  }

  /// Sets the default template
  Future<String?> setDefaultTemplate(IoTDeviceTemplate? template) async {
    try {
      return await _iotDevicesTemplatesRepository
          ?.setDefaultTemplate(
        templateID: template?.templateID,
      )
          .then((value) {
        emit(state.copyWith(defaultTemplateID: template?.templateID));
        return null;
      });
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e);
    }
  }

  /// Fetches the default template
  Future<String?> fetchDefaultTemplate() async {
    try {
      return await _iotDevicesTemplatesRepository
          ?.fetchDefaultTemplate()
          .then((value) {
        emit(state.copyWith(defaultTemplateID: value));
        return null;
      });
    } catch (e) {
      return HelperFunctions.handleFireStoreError(e,
          defaultErrorMessage:
              'Unable to load default template. Please Refresh the Page');
    }
  }
}

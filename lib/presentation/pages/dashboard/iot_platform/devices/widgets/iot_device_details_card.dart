import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/custom_location.dart';
import 'package:management_dashboard/data/models/classes/iot_device.dart';
import 'package:management_dashboard/data/models/classes/iot_device_template.dart';
import 'package:management_dashboard/data/repositories/firebase/places_api_repository.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';
import 'package:management_dashboard/logic/cubits/iot_device_management/iot_device_management_cubit.dart';
import 'package:management_dashboard/logic/cubits/iot_device_templates/iot_device_templates_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/choose_device_lcoation_map.dart';
import 'package:management_dashboard/presentation/pages/dashboard/iot_platform/devices/widgets/dashboard_location_search_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/models/custom_place.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_date_form_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_drop_down_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_text_form_field.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/responsive_widgets/dashboard_responsive_container.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_text_button.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';
import 'package:responsive_ui/responsive_ui.dart';

class IoTDeviceDetailsCard extends StatefulWidget {
  /// A card to display the ioT Device details
  const IoTDeviceDetailsCard({
    super.key,
    this.ioTDevice,
    required this.onUpdated,
  });

  /// Is this card in edit mode
  final IoTDevice? ioTDevice;

  /// Callback when the device is updated
  final VoidCallback onUpdated;

  @override
  State<IoTDeviceDetailsCard> createState() => _IoTDeviceDetailsCardState();
}

class _IoTDeviceDetailsCardState extends State<IoTDeviceDetailsCard> {
  /// The form key
  final _formKey = GlobalKey<FormBuilderState>();

  /// ID of the Selected Place
  late final Rxn<LatLng> selectedLatLng =
      Rxn<LatLng>(widget.ioTDevice?.location?.latLng);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < K.mobileSize;

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
                    CustomText(
                      '${widget.ioTDevice != null ? 'Update' : 'Add'} Device Details',
                      style: K.headingStyleDashboard,
                    ),
                    const SizedBox(width: 10),
                    BlocProvider(
                      create: (context) => IoTDeviceManagementCubit(
                          companyName:
                              BlocProvider.of<AuthenticationCubit>(context)
                                  .state
                                  .company!),
                      child: Builder(
                        builder: (context) => CustomTextButton(
                          text: widget.ioTDevice != null ? 'Update' : 'Submit',
                          fontSize: 12,
                          onPressed: () async {
                            if (_formKey.currentState?.saveAndValidate() ??
                                false) {
                              LatLng? newLatLng;

                              try {
                                List<String> latLng = _formKey
                                    .currentState!.fields['latLng']!.value
                                    .split(',');

                                newLatLng = LatLng(
                                  double.parse(latLng[0]),
                                  double.parse(latLng[1]),
                                );
                              } catch (e) {
                                _formKey.currentState?.fields['latLng']?.invalidate(
                                    'Please enter LatLng in the correct format (lat,lng)');
                                return;
                              }

                              IoTDevice iotDevice = IoTDevice(
                                deviceName: _formKey
                                    .currentState?.fields['deviceName']?.value,
                                serialNumber: _formKey.currentState
                                    ?.fields['serialNumber']?.value,
                                deviceID: _formKey
                                    .currentState?.fields['deviceID']?.value,
                                hardwareVersion: _formKey.currentState
                                    ?.fields['hardwareVersion']?.value,
                                firmwareVersion: _formKey.currentState
                                    ?.fields['firmwareVersion']?.value,
                                installedDate: _formKey.currentState
                                    ?.fields['installedDate']?.value,
                                location: CustomLocation(
                                  latLng: newLatLng,
                                  address: _formKey
                                      .currentState
                                      ?.fields['address']
                                      ?.value
                                      .formattedAddress,
                                  tag: _formKey.currentState
                                      ?.fields['locationTag']?.value,
                                ),
                                deviceTemplateID: _formKey
                                    .currentState
                                    ?.fields['deviceTemplate']
                                    ?.value
                                    ?.templateID,
                              );

                              String? error = await BlocProvider.of<
                                      IoTDeviceManagementCubit>(context)
                                  .updateIoTDevice(iotDevice);

                              if (error != null) {
                                K.showToast(message: error);
                                return;
                              }

                              K.showToast(
                                  message: 'Device Updated Successfully');

                              widget.onUpdated();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap16(changeForMobile: false),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 600,
                        child: Column(
                          children: [
                            Responsive(
                              runSpacing: K.gap16Mobile,
                              children: [
                                Div(
                                  divison: const Division(colM: 6),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: isMobile ? 0 : 16),
                                    child: DashboardTextFormField(
                                      name: 'deviceName',
                                      hint: 'Display Name',
                                      initialValue:
                                          widget.ioTDevice?.deviceName,
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
                                    ),
                                  ),
                                ),
                                Div(
                                  divison: const Division(colM: 6),
                                  child: DashboardTextFormField(
                                    name: 'serialNumber',
                                    hint: 'Serial Number',
                                    initialValue:
                                        widget.ioTDevice?.serialNumber,
                                  ),
                                ),
                              ],
                            ),
                            const Gap16(),
                            DashboardTextFormField(
                              label: 'UNIQUE ID (i.e. MAC Address)',
                              name: 'deviceID',
                              hint: '25:D5:5S:87:54',
                              enabled: widget.ioTDevice == null,
                              initialValue: widget.ioTDevice?.deviceID,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            const Gap16(),
                            DashboardTextFormField(
                              label: 'Hardware Version',
                              name: 'hardwareVersion',
                              hint: 'V1.0',
                              initialValue: widget.ioTDevice?.hardwareVersion,
                            ),
                            const Gap16(),
                            DashboardTextFormField(
                              label: 'Firmware Version',
                              name: 'firmwareVersion',
                              hint: 'V12.2',
                              initialValue: widget.ioTDevice?.firmwareVersion,
                            ),
                            const Gap16(),
                            BlocBuilder<IoTDeviceTemplatesCubit,
                                IoTDeviceTemplatesState>(
                              builder: (context, state) {
                                List<IoTDeviceTemplate> templates =
                                    state.deviceTemplates;

                                IoTDeviceTemplate? initialTemplate =
                                    BlocProvider.of<IoTDeviceTemplatesCubit>(
                                            context)
                                        .getTemplateOrDefault(
                                            widget.ioTDevice?.deviceTemplateID);

                                return DashboardDropDownField(
                                  name: 'deviceTemplate',
                                  label: 'Device Template',
                                  enabled: templates.isNotEmpty,
                                  hint: 'Select a template',
                                  initialValue: state.deviceTemplates.isNotEmpty
                                      ? initialTemplate
                                      : 'No Templates',
                                  stringItems: state.deviceTemplates.isNotEmpty
                                      ? null
                                      : const ['No Templates'],
                                  widgetItems: state.deviceTemplates.isEmpty
                                      ? null
                                      : state.deviceTemplates
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e.templateName,
                                                style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(),
                                  ]),
                                );
                              },
                            ),
                            const Gap16(),
                            const DashboardDropDownField(
                              name: 'dashboardTemplate',
                              label: 'Dashboard Template',
                              enabled: false,
                              hint: 'Select a template',
                              initialValue: 'Manaframs_Farm_Dashboard_V1',
                              stringItems: ['Manaframs_Farm_Dashboard_V1'],
                            ),
                            const Gap16(),
                            BlocBuilder<AuthenticationCubit,
                                AuthenticationState>(
                              builder: (context, state) {
                                return DashboardTextFormField(
                                  label: 'Owner',
                                  name: 'owner',
                                  hint: 'LOOFT',
                                  initialValue: state.company,
                                );
                              },
                            ),
                            const Gap16(),
                            const DashboardTextFormField(
                              label: 'Customer ',
                              name: 'customer',
                              hint: '-',
                              enabled: false,
                            ),
                            const Gap16(),
                            DashboardDateFormField(
                              label: 'Build Date / Installed Date',
                              name: 'installedDate',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              initialValue: widget.ioTDevice?.installedDate,
                            ),
                            const Gap16(),
                            ChooseDeviceLocationMap(
                              formKey: _formKey,
                              selectedLatLng: selectedLatLng,
                              onLatLngChanged: (newLatLng) async {
                                try {
                                  await PlacesAPIRepository
                                      .getAddressFromLatLng(
                                    lat: newLatLng.latitude,
                                    lng: newLatLng.longitude,
                                  ).then((value) {
                                    _formKey.currentState?.fields['address']
                                        ?.didChange(CustomPlace(
                                      formattedAddress: value.data,
                                    ));
                                  });
                                } catch (e) {
                                  HelperFunctions.printDebug(e);
                                }
                              },
                            ),
                            const Gap16(),
                            DashboardLocationSearchField(
                              label: 'Address',
                              name: 'address',
                              hint: 'Search Address',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              initialValue: widget.ioTDevice?.location?.address,
                              onLocationSelected: (place) async {
                                if (place.placeID == null) return;

                                try {
                                  await PlacesAPIRepository.getPlaceDetails(
                                          placeID: place.placeID!)
                                      .then((value) {
                                    Map<String, dynamic> location =
                                        value.data as Map<String, dynamic>;

                                    selectedLatLng.value = LatLng(
                                        location['lat'], location['lng']);
                                  });
                                } catch (e) {
                                  HelperFunctions.printDebug(e);
                                }
                              },
                            ),
                            const Gap16(),
                            DashboardTextFormField(
                              label: 'Location Tag',
                              name: 'locationTag',
                              hint: 'Room 5, Hilton Hotel',
                              initialValue: widget.ioTDevice?.location?.tag,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/widgets/buttons/rounded_text_button.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class ChooseDeviceLocationMap extends StatefulWidget {
  /// A custom widget to display google maps
  const ChooseDeviceLocationMap({
    super.key,
    required this.formKey,
    required this.selectedLatLng,
    required this.onLatLngChanged,
  });

  /// The form key
  final GlobalKey<FormBuilderState> formKey;

  /// The initial position of the map
  final Rxn<LatLng> selectedLatLng;

  /// The callback when the lat lng changes
  final Function(LatLng) onLatLngChanged;

  @override
  State<ChooseDeviceLocationMap> createState() =>
      _ChooseDeviceLocationMapState();
}

class _ChooseDeviceLocationMapState extends State<ChooseDeviceLocationMap> {
  /// The google map controller
  late final GoogleMapController _controller;

  /// The default address
  final LatLng defaultAddress =
      const LatLng(37.42796133580664, -122.085749655962);

  @override
  void initState() {
    super.initState();

    widget.selectedLatLng.listen((p0) {
      try {
        widget.formKey.currentState!.fields['latLng']!.didChange(
          getTextFieldLatLng(widget.selectedLatLng.value),
        );
        widget.formKey.currentState!.fields['latLng']!.validate();
        _controller.animateCamera(CameraUpdate.newLatLng(p0!));
      } catch (e) {}
    });

    if (widget.selectedLatLng.value == null) {
      _determinePosition().then((Position position) {
        widget.selectedLatLng.value =
            LatLng(position.latitude, position.longitude);
      }).catchError((e) {
        K.showToast(message: e);
      });
    }
  }

  /// Updates the lat lng values
  void updateLatLng(LatLng latLng) {}

  /// Returns the text field lat lng
  String? getTextFieldLatLng(LatLng? latLng) {
    if (latLng == null) return null;

    return '${latLng.latitude},${latLng.longitude}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(
              color: state.opacity10,
            ),
            color: K.white5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                'Location Map',
                style: TextStyle(
                  color: state.opacity40,
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _HelperTextField(
                      hint: '37.42796133580664,-122.085749655962',
                      name: 'latLng',
                      initialValue:
                          getTextFieldLatLng(widget.selectedLatLng.value) ??
                              getTextFieldLatLng(defaultAddress),
                    ),
                  ),
                  RoundedTextButton(
                    child: const CustomText(
                      'Update Address',
                      selectable: false,
                      style: TextStyle(fontSize: 12),
                    ),
                    onPressed: () async {
                      try {
                        widget.formKey.currentState!.fields['latLng']!
                            .validate();

                        List<String> latLng = widget
                            .formKey.currentState!.fields['latLng']!.value
                            .split(',');

                        widget.selectedLatLng.value = LatLng(
                          double.parse(latLng[0]),
                          double.parse(latLng[1]),
                        );

                        _controller.animateCamera(CameraUpdate.newLatLng(
                            widget.selectedLatLng.value!));
                        await widget
                            .onLatLngChanged(widget.selectedLatLng.value!);
                      } catch (e) {
                        widget.formKey.currentState!.fields['latLng']!.invalidate(
                            'Please enter LatLng in the correct format (lat,lng)');
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  child: Obx(
                    () => GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: widget.selectedLatLng.value ?? defaultAddress,
                        zoom: 15,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;

                        if (widget.selectedLatLng.value != null) {
                          _controller.animateCamera(CameraUpdate.newLatLng(
                              widget.selectedLatLng.value!));
                        }
                      },
                      onTap: (LatLng latLng) {
                        widget.selectedLatLng.value = latLng;
                      },
                      onLongPress: (LatLng latLng) {
                        if (widget.selectedLatLng.value != null) {
                          _controller.animateCamera(CameraUpdate.newLatLng(
                              widget.selectedLatLng.value!));
                        }
                      },
                      markers: {
                        Marker(
                          markerId: const MarkerId('1'),
                          position:
                              widget.selectedLatLng.value ?? defaultAddress,
                        ),
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HelperTextField extends StatelessWidget {
  const _HelperTextField({
    required this.name,
    required this.hint,
    this.initialValue,
  });

  /// The name of the text field
  final String name;

  /// The hint of the text field
  final String hint;

  /// The initial value of the text field
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return FormBuilderTextField(
          name: name,
          initialValue: initialValue,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: state.opacity20,
            ),
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        );
      },
    );
  }
}

/// Returns the current position
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

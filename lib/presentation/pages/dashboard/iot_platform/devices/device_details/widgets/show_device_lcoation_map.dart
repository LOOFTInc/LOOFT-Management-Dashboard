import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class ShowDeviceLocationMap extends StatelessWidget {
  /// A Custom widget to show device location on google maps
  const ShowDeviceLocationMap({
    super.key,
    this.latLng,
  });

  /// The latitude and longitude of the location to display
  final LatLng? latLng;

  @override
  Widget build(BuildContext context) {
    if (latLng == null) {
      return const Center(
        child: CustomText('Please update the location of this device.'),
      );
    }

    return HtmlWidget(
      '''
      <iframe
        width="560"
        height="315"
        referrerpolicy="no-referrer-when-downgrade"
        src="https://www.google.com/maps/embed/v1/place?key=${K.mapsAPIKey}&q=${latLng?.latitude},${latLng?.longitude}&zoom=15"
      >
      </iframe>
      ''',
      factoryBuilder: () => _WidgetFactory(webView: true),
    );
  }
}

class _WidgetFactory extends WidgetFactory {
  @override
  final bool webView;

  _WidgetFactory({
    required this.webView,
  });
}

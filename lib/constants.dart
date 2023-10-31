import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

/// Constants used throughout the app
class K {
  // Colors
  static const Color primaryPink = Color(0xFFE2296A);
  static const Color primaryBlue = Color(0xFF29ABE2);
  static const Color white = Colors.white;
  static const Color black = Color(0xFF1c1c1c);
  static Color black5 = black.withOpacity(0.05);
  static Color black10 = black.withOpacity(0.1);
  static Color black20 = black.withOpacity(0.2);
  static Color black40 = black.withOpacity(0.4);
  static Color black50 = black.withOpacity(0.5);
  static Color black80 = black.withOpacity(0.8);
  static Color white5 = white.withOpacity(0.05);
  static Color white10 = white.withOpacity(0.1);
  static Color white20 = white.withOpacity(0.2);
  static Color white40 = white.withOpacity(0.4);
  static Color white50 = white.withOpacity(0.5);
  static Color white80 = white.withOpacity(0.8);
  static const Color cardsLightBackgroundColor = Color(0xFFf7f9fb);
  static const Color blueE3F5FF = Color(0xFFE3F5FF);
  static const Color purpleE5ECF6 = Color(0xFFE5ECF6);
  static const Color pinkFFDEDE = Color(0xFFFFDEDE);
  static const Color blueE0EEF4 = Color(0xFFe0eef4);
  static const Color redFF4747 = Color(0xFFFF4747);
  static const Color grey3C3A3A = Color(0xFF3C3A3A);

  // Sizes
  static const double maxScreenWidth = 1460;
  static const double mobileSize = 768;
  static const double padding = 16;
  static const double gap16Desktop = 16;
  static const double gap16Mobile = 12;
  static const double gap28Desktop = 28;
  static const double gap28Mobile = 14;

  // Text Styles
  static const TextStyle headingStyleAuth = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle headingStyleDashboard = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // Strings
  static const String unexpectedError =
      'Unexpected error occurred. Please try again! If the error persists, contact support.';
  static const String mapsAPIKey = 'Your Maps API Key';

  /// Shows a toast with the given message
  static void showToast({
    dynamic message,
  }) {
    final FToast fToast = FToast();
    fToast.init(AppRoutes.router.routerDelegate.navigatorKey.currentContext!);

    fToast.showToast(
      positionedToastBuilder: (context, child) {
        return Positioned(
          bottom: 16.0,
          right: 16.0,
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryBlue,
        ),
        child: CustomText(
          message.toString(),
          selectable: false,
          opacity: OpacityColors.rop100,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      toastDuration: const Duration(seconds: 3),
    );
  }
}

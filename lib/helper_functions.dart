import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

class HelperFunctions {
  /// Returns Location for the given route
  static String? getLocationForRoute(BuildContext context, CustomRoute route) {
    return GoRouter.of(context).configuration.locationForRoute(
        GoRouter.of(context)
            .configuration
            .findMatch(GoRouterState.of(context)
                .namedLocation(route.name, pathParameters: route.pathParams))
            .matches
            .last
            .route);
  }

  /// Returns the error message from the given error
  /// Also prints the error if the app is in debug mode
  static String? handleFireStoreError(
    dynamic e, {
    String? defaultErrorMessage,
  }) {
    if (e == null) {
      return null;
    }

    printDebug(e);
    if (e is FirebaseException) {
      return e.message;
    }

    if (e.toString().contains('permission-denied')) {
      return 'Permission denied';
    }

    return defaultErrorMessage ?? K.unexpectedError;
  }

  /// Compares two values (custom made for handling null values)
  static int compare(dynamic a, dynamic b) {
    if (a == null) {
      return -1;
    } else if (b == null) {
      return 1;
    }
    return a.compareTo(b);
  }

  /// Returns result or error from the given result
  /// Also prints the error if the app is in debug mode
  static String? handleCloudFunctionsResult(
    dynamic result, {
    String? defaultErrorMessage,
  }) {
    if (result is Map<String, dynamic>?) {
      if (result?['result'] != null) {
        return null;
      }

      return result?['error'] ?? defaultErrorMessage ?? K.unexpectedError;
    }

    return handleFireStoreError(result,
        defaultErrorMessage: defaultErrorMessage);
  }

  /// Opens a url with the given string url
  static void openURL({
    required String url,
  }) async =>
      await canLaunchUrl(Uri.parse(url))
          ? launchUrl(Uri.parse(url), webOnlyWindowName: '_self')
          : K.showToast(message: 'Could not open $url');

  /// Checks if a value has no decimal portion
  static bool hasNoDecimal(num value) =>
      value is int || value == value.roundToDouble();

  /// Returns the given value with maximum up to the given number of decimal places
  static String? getUpToNDecimalPlaces(dynamic value, int n) {
    if (value == null) {
      return '?';
    }

    try {
      value = double.parse(value.toString());
    } catch (e) {
      return value.toString();
    }

    if (hasNoDecimal(value)) {
      return value.toString();
    }

    for (int i = n; i > 0; i--) {
      if (value.toStringAsFixed(i).endsWith('0')) {
        return value.toStringAsFixed(i - 1);
      }
    }

    return value.toStringAsFixed(n);
  }

  /// Get the step of the password strength
  static int getPasswordStrengthStep(double strength) {
    if (strength == 0) {
      return 0;
    } else if (strength < .3) {
      return 1;
    } else if (strength < .5) {
      return 2;
    } else if (strength < .7) {
      return 3;
    }
    return 4;
  }

  /// Returns day of week as String from int value
  static String getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      default:
        return 'Sun';
    }
  }

  /// Generates a random double between the given min and max
  static double generateRandomDouble(num min, num max) =>
      Random().nextDouble() * (max - min) + min;

  /// Returns Sign of the given value
  ///
  /// If the value is negative, it returns ''
  ///
  /// If the value is positive, it returns '-'
  static String getSignFromValue(double value) {
    if (value > 0) {
      return '+';
    }
    return '';
  }

  /// Convert the given value to a string with a suffix e.g K,M,B,T,Q
  ///
  /// K for thousand, M for million, B for billion, T for trillion, Q for quadrillion
  static String doubleToStringWithQuantifierSuffix(double value) {
    if (value < 10000) {
      if (value < 1000) {
        return value.round().toString();
      } else {
        return '${value ~/ 1000},${value % 1000}';
      }
    } else if (value < 1000000) {
      return '${(value / 1000).round()}K';
    } else if (value < 1000000000) {
      return '${(value / 1000000).round()}M';
    } else if (value < 1000000000000) {
      return '${(value / 1000000000).round()}B';
    } else if (value < 1000000000000000) {
      return '${(value / 1000000000000).round()}T';
    } else {
      return '${(value / 1000000000000000).round()}Q';
    }
  }

  /// Return the plural or singular form of the given text based on the value
  static getPluralOrSingular(int value, String text) {
    if (value == 1) {
      return '$value $text';
    }
    return '$value ${text}s';
  }

  /// Returns the formatted date
  /// e.g 8/23/2023 1:38 PM
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('d MMM y,').add_jm().format(dateTime);
  }

  /// Returns the formatted registration date
  static String getFormattedRegistrationDate(DateTime registrationDate) {
    Duration difference = DateTime.now().difference(registrationDate);

    if (difference.inSeconds < 10) {
      return 'Just now';
    } else if (difference.inMinutes < 1) {
      return '${getPluralOrSingular(difference.inSeconds, 'second')} ago';
    } else if (difference.inHours < 1) {
      return '${getPluralOrSingular(difference.inMinutes, 'minute')} ago';
    } else if (difference.inDays < 1) {
      return '${getPluralOrSingular(difference.inHours, 'hour')} ago';
    } else if (difference.inDays < 2) {
      return 'Yesterday';
    } else {
      return DateFormat().add_yMMMd().format(registrationDate);
    }
  }

  /// Returns the formatted Last Updated date for Devices
  static String getFormattedLastUpdatedDate(DateTime lastUpdated) {
    Duration difference = DateTime.now().difference(lastUpdated);

    if (difference.inDays == 0 && lastUpdated.day == DateTime.now().day) {
      return DateFormat.jm().format(lastUpdated);
    }

    return DateFormat.yMd().add_jm().format(lastUpdated);
  }

  /// Returns the text for the notification time based on the given time
  static String getHowLongAgoFromDateTime(DateTime when) {
    final now = DateTime.now();
    final difference = now.difference(when);

    if (difference.inSeconds < 10) {
      return 'Just now';
    }

    if (difference.inMinutes == 0) {
      return '${difference.inSeconds} seconds ago';
    }

    if (difference.inHours == 0) {
      return '${getPluralOrSingular(difference.inMinutes, 'minute')} ago';
    }

    if (difference.inHours < 13) {
      return '${getPluralOrSingular(difference.inHours, 'hour')} ago';
    }

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${getPluralOrSingular(difference.inDays, 'day')} ago';
    } else if (difference.inDays < 14) {
      return 'Last week';
    } else if (difference.inDays < 21) {
      return '2 weeks ago';
    } else if (difference.inDays < 28) {
      return '3 weeks ago';
    } else if (difference.inDays < 60) {
      return 'Last month';
    } else if (difference.inDays < 90) {
      return '2 months ago';
    } else if (difference.inDays < 120) {
      return '3 months ago';
    } else if (difference.inDays < 150) {
      return '4 months ago';
    } else if (difference.inDays < 180) {
      return '5 months ago';
    } else if (difference.inDays < 210) {
      return '6 months ago';
    } else if (difference.inDays < 240) {
      return '7 months ago';
    } else if (difference.inDays < 270) {
      return '8 months ago';
    } else if (difference.inDays < 300) {
      return '9 months ago';
    } else if (difference.inDays < 330) {
      return '10 months ago';
    } else if (difference.inDays < 365) {
      return '11 months ago';
    } else {
      return 'More than a year ago';
    }
  }

  /// Shows a toast with the text for unexpected error
  /// If the app is in debug mode, it also prints the error
  static void showUnexpectedError(dynamic e) {
    printDebug(e);

    K.showToast(message: K.unexpectedError);
  }

  /// Prints the given message if the app is in debug mode
  static void printDebug(dynamic message) {
    if (kDebugMode) {
      print(message);
    }
  }

  /// Adds a zero before a single digit number
  static String twoDigits(int n) => n.toString().padLeft(2, "0");

  /// Shows a toast with the given message
  static void showTopCenterToast({
    required String message,
  }) {
    final FToast fToast = FToast();
    fToast.init(AppRoutes.router.routerDelegate.navigatorKey.currentContext!);

    fToast.showToast(
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: 80,
          left: 0,
          right: 0,
          child: child,
        );
      },
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: state.themeMode == ThemeMode.dark
                  ? const Color(0xFF4F0000)
                  : const Color(0xFFFFD1D1),
            ),
            child: CustomText(
              message.toString(),
              selectable: false,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          );
        },
      ),
      toastDuration: const Duration(milliseconds: 2500),
    );
  }
}

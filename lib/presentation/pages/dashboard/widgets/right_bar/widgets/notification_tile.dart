import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/custom_notification.dart';
import 'package:management_dashboard/data/models/enums/notification_types.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class NotificationTile extends StatelessWidget {
  /// Notification tile widget
  const NotificationTile({
    super.key,
    required this.index,
    required this.notification,
  });

  /// Index at which this notification lies - decides the background color
  final int index;

  /// Notification object
  final CustomNotification notification;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: index % 2 == 0 ? K.blueE3F5FF : K.purpleE5ECF6,
        ),
        child: SvgPicture.asset(
          notification.type.iconSvgPath,
          height: 16,
          width: 16,
        ),
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: CustomText(
          notification.notificationText,
          style: const TextStyle(
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
          ),
          showTooltip: true,
        ),
      ),
      subtitle: Align(
        alignment: Alignment.centerLeft,
        child: CustomText(
          HelperFunctions.getFormattedRegistrationDate(notification.when),
          opacity: OpacityColors.op40,
        ),
      ),
    );
  }
}

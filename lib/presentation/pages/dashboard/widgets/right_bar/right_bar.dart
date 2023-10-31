import 'package:flutter/material.dart';
import 'package:management_dashboard/data/models/classes/custom_notification.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

import '../../../../../data/models/enums/notification_types.dart';

class RightBar extends StatelessWidget {
  /// Right bar widget
  const RightBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CustomNotification> notifications = [
      CustomNotification(
        notificationText: 'You have a bug that needs to be fixed.',
        when: DateTime.now(),
        type: NotificationTypes.bug,
      ),
      CustomNotification(
        notificationText: 'New user registered',
        when: DateTime.now().subtract(const Duration(minutes: 59)),
        type: NotificationTypes.customer,
      ),
      CustomNotification(
        notificationText: 'You have a bug that needs to be fixed.',
        when: DateTime.now().subtract(const Duration(hours: 12)),
        type: NotificationTypes.bug,
      ),
      CustomNotification(
        notificationText: 'Andi Lane subscribed to you',
        when: DateTime.now().subtract(const Duration(hours: 14)),
        type: NotificationTypes.subscription,
      ),
    ];

    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(4),
              child: CustomText(
                'Notifications',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            // const SizedBox(height: 16),
            // Column(
            //   children: List.generate(
            //     notifications.length,
            //     (index) => NotificationTile(
            //       index: index,
            //       notification: notifications.elementAt(index),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

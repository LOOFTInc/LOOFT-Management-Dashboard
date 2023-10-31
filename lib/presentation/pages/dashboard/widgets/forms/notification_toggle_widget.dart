import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/widgets/custom_check_box.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class NotificationToggleWidget extends StatefulWidget {
  /// Email Preference Widget
  const NotificationToggleWidget({
    super.key,
    required this.title,
    required this.selected,
  });

  /// Title of the widget
  final String title;

  /// Whether the widget is selected or not
  final bool selected;

  @override
  State<NotificationToggleWidget> createState() =>
      _NotificationToggleWidgetState();
}

class _NotificationToggleWidgetState extends State<NotificationToggleWidget> {
  late bool selected = widget.selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomCheckBox(
            value: selected,
            onChanged: (value) {
              setState(() {
                selected = value ?? false;
              });
            },
          ),
          const SizedBox(width: 5),
          const CustomText('Email'),
        ],
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: CustomText(
          widget.title,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

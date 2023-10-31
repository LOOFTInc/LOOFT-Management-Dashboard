import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/widgets/custom_check_box.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

import '../../../../../data/models/enums/opacity_colors.dart';

class PreferencesSelectionWidget extends StatelessWidget {
  /// Email Preference Widget
  const PreferencesSelectionWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onChanged,
  });

  /// Title of the widget
  final String title;

  /// Subtitle of the widget
  final String subtitle;

  /// Whether the widget is selected or not
  final bool selected;

  /// OnChanged
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomCheckBox(
        value: selected,
        onChanged: onChanged,
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: CustomText(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      subtitle: Align(
        alignment: Alignment.centerLeft,
        child: CustomText(
          subtitle,
          style: const TextStyle(fontSize: 12),
          opacity: OpacityColors.op40,
        ),
      ),
    );
  }
}

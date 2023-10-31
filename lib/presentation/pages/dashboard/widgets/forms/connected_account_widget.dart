import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_switch_button.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

import '../../../../../data/models/enums/opacity_colors.dart';

class ConnectedAccountWidget extends StatefulWidget {
  /// Connected Account Widget
  const ConnectedAccountWidget({
    super.key,
    required this.leadingSvgPath,
    required this.title,
    required this.subtitle,
    required this.selected,
  });

  /// Leading SVG Path
  final String leadingSvgPath;

  /// Title of the widget
  final String title;

  /// Subtitle of the widget
  final String subtitle;

  /// Whether the widget is selected or not
  final bool selected;

  @override
  State<ConnectedAccountWidget> createState() => _ConnectedAccountWidgetState();
}

class _ConnectedAccountWidgetState extends State<ConnectedAccountWidget> {
  late bool selected = widget.selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        widget.leadingSvgPath,
        width: 32,
        height: 32,
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: CustomText(
          widget.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      subtitle: Align(
        alignment: Alignment.centerLeft,
        child: CustomText(
          widget.subtitle,
          style: const TextStyle(fontSize: 12),
          opacity: OpacityColors.op40,
        ),
      ),
      trailing: CustomSwitchButton(
        selected: selected,
        onChanged: (value) {
          setState(() {
            selected = value;
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../constants.dart';

class CustomSwitchButton extends StatelessWidget {
  /// Custom Switch Button Widget
  const CustomSwitchButton({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  /// Value of the switch button
  final bool selected;

  /// Callback for when the switch button is changed
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: selected,
      activeColor: K.primaryBlue,
      onChanged: onChanged,
    );
  }
}

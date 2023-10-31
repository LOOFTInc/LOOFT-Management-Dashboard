import 'package:flutter/material.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/presentation/widgets/click_cursor_on_hover.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class TextLinkButton extends StatelessWidget {
  /// Text that can be clicked
  const TextLinkButton({
    super.key,
    this.style = const TextStyle(),
    required this.text,
    this.onPressed,
  });

  /// The text of the button
  final String text;

  /// The Style of the Text
  final TextStyle style;

  /// The onPressed of the button
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ClickCursorOnHover(
      child: GestureDetector(
        onTap: onPressed,
        child: CustomText(
          text,
          selectable: false,
          style: style.copyWith(color: style.color ?? K.primaryBlue),
        ),
      ),
    );
  }
}

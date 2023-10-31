import 'package:flutter/material.dart';

import '../../../../../data/models/enums/opacity_colors.dart';
import '../../../../widgets/text_widgets/custom_text.dart';

class CustomTableColumn extends StatelessWidget {
  /// Helper Container with left aligning child
  const CustomTableColumn({
    super.key,
    required this.text,
    this.leading,
    this.decoration,
    this.opacity,
    this.child,
    this.textStyle = const TextStyle(),
    this.trailing,
    this.selectable = true,
  });

  /// Child of the container
  final String text;

  /// Widget to be displayed before the text
  final Widget? leading;

  /// Decoration of the container
  final BoxDecoration? decoration;

  /// Opacity of the text
  final OpacityColors? opacity;

  /// Child of the container
  final Widget? child;

  /// Text style of the text
  final TextStyle textStyle;

  /// Widget to be displayed after the text
  final Widget? trailing;

  /// If the text is selectable
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: decoration,
      child: child ??
          Row(
            children: [
              if (leading != null) leading!,
              if (leading != null) const SizedBox(width: 8),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text,
                    opacity: opacity,
                    style: textStyle.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontSize: textStyle.fontSize ?? 14,
                    ),
                    selectable: selectable,
                  ),
                ),
              ),
              if (trailing != null) const SizedBox(width: 8),
              if (trailing != null)
                Align(alignment: Alignment.centerRight, child: trailing!),
            ],
          ),
    );
  }
}

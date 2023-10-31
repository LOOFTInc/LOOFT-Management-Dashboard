import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';

import '../../../data/models/enums/opacity_colors.dart';

class CustomRichText extends StatelessWidget {
  /// Custom RichText Widget with Theme Support.
  ///
  /// Takes a List of texts and a List of onPressed Functions. Every Second text will be clickable and will call the onPressed Function.
  const CustomRichText({
    super.key,
    required this.textSpanList,
    this.selectable = true,
    this.style = const TextStyle(),
    this.opacity,
    this.textAlign,
    this.maxLines,
    this.staticColor,
  });

  /// List of texts to show
  final List<InlineSpan> textSpanList;

  /// Whether the text is selectable
  final bool selectable;

  /// Style of the Text
  final TextStyle style;

  /// Opacity of the Text
  final OpacityColors? opacity;

  /// Alignment of the Text
  final TextAlign? textAlign;

  /// Max Lines of the Text
  final int? maxLines;

  /// Static Color of the Text
  final Color? staticColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final textWidget = Text.rich(
          TextSpan(children: textSpanList),
          style: style.copyWith(
            color: staticColor ?? opacity?.getColorFromThemeState(state),
          ),
          textAlign: textAlign,
          maxLines: maxLines,
        );

        if (selectable) {
          return SelectionArea(
            child: textWidget,
          );
        }

        return textWidget;
      },
    );
  }
}

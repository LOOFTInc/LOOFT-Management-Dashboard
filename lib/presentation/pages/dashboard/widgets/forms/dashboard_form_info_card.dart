import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/widgets/custom_container.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

import '../../../../../constants.dart';

class DashboardFormInfoCard extends StatelessWidget {
  const DashboardFormInfoCard({
    super.key,
    this.headingText,
    this.subTitleText,
    this.heading,
    this.subTitle,
    required this.leading,
    this.padding,
  });

  /// Leading widget of the card
  final Widget leading;

  /// Heading text of the card
  final String? headingText;

  /// Subtitle text of the card
  final String? subTitleText;

  /// Heading widget of the card
  final Widget? heading;

  /// Subtitle widget of the card
  final Widget? subTitle;

  /// Padding of the card
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final Widget headingWidget = CustomText(
      '$headingText',
      style: const TextStyle(fontSize: 14),
    );

    final Widget subTitleWidget = CustomText(
      '$subTitleText',
      style: const TextStyle(fontSize: 12),
      opacity: OpacityColors.op40,
    );

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return CustomContainer(
          padding: padding ?? const EdgeInsets.all(8),
          staticBackgroundColor: state.themeMode == ThemeMode.dark
              ? K.white5
              : K.purpleE5ECF6.withOpacity(0.5),
          child: ListTile(
            leading: leading,
            title: Align(
              alignment: Alignment.centerLeft,
              child: heading == null && headingText == null
                  ? (subTitle ?? subTitleWidget)
                  : (heading ?? headingWidget),
            ),
            titleAlignment: ListTileTitleAlignment.titleHeight,
            subtitle: Align(
              alignment: Alignment.centerLeft,
              child: (heading == null && headingText == null) ||
                      (subTitle == null && subTitleText == null)
                  ? null
                  : (subTitle ?? subTitleWidget),
            ),
          ),
        );
      },
    );
  }
}

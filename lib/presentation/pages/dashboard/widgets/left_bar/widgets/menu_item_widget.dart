import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/data/models/enums/side_bar_states.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/side_bars/side_bars_cubit.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/left_bar/widgets/left_bar_gap.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

import '../../../../../../constants.dart';

class MenuItemWidget extends StatelessWidget {
  /// Dashboard Menu Item Widget
  const MenuItemWidget({
    super.key,
    this.iconSvgPath,
    required this.route,
    this.isSelected,
    this.onPressed,
  });

  /// Icon SVG Path
  final String? iconSvgPath;

  /// The route at which the tile is selected
  final CustomRoute route;

  /// Whether the tile is selected or not
  final bool? isSelected;

  /// The function to be called when the tile is pressed
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return TextButton(
          onPressed: onPressed ??
              () {
                context.goNamed(route.name);
              },
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(isSelected ??
                    GoRouterState.of(context).fullPath ==
                        HelperFunctions.getLocationForRoute(context, route)
                ? (themeState.themeMode == ThemeMode.dark
                    ? K.white10
                    : K.black5)
                : Colors.transparent),
          ),
          child: BlocBuilder<SideBarsCubit, SideBarsState>(
            builder: (context, sideBarsState) {
              return sideBarsState.leftBarState == SideBarStates.collapsed
                  ? iconSvgPath == null
                      ? const SizedBox(width: 20)
                      : CustomSvg(
                          svgPath: iconSvgPath!,
                          size: 20,
                        )
                  : Row(
                      children: [
                        const SizedBox(width: 16),
                        const LeftBarGap(),
                        iconSvgPath == null
                            ? const SizedBox(width: 20)
                            : CustomSvg(
                                svgPath: iconSvgPath!,
                                size: 20,
                              ),
                        const LeftBarGap(),
                        Flexible(
                          child: CustomText(
                            route.name,
                            selectable: false,
                          ),
                        ),
                      ],
                    );
            },
          ),
        );
      },
    );
  }
}

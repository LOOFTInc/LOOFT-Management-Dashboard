import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/enums/side_bar_states.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/side_bars/side_bars_cubit.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/left_bar/widgets/left_bar_gap.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/left_bar/widgets/menu_item_widget.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class ExpandableMenuItemWidget extends StatelessWidget {
  /// Dashboard Menu Item Widget
  const ExpandableMenuItemWidget({
    super.key,
    required this.iconSvgPath,
    required this.children,
    required this.route,
  });

  /// Icon SVG Path
  final String iconSvgPath;

  /// Menu Item Widget List to show when expanded
  final List<MenuItemWidget> children;

  /// The selected route
  final CustomRoute route;

  @override
  Widget build(BuildContext context) {
    final List<String?> allPaths = children
        .map((e) => HelperFunctions.getLocationForRoute(context, e.route))
        .toList();
    allPaths.add(HelperFunctions.getLocationForRoute(context, route));

    final ExpandableController controller = ExpandableController(
        initialExpanded: GoRouter.of(context)
            .configuration
            .findMatch(GoRouterState.of(context).matchedLocation)
            .matches
            .any((element) {
      try {
        return (element.route as GoRoute).name == route.name;
      } catch (e) {
        return false;
      }
    }));

    return BlocBuilder<SideBarsCubit, SideBarsState>(
      builder: (context, sideBarState) {
        if (sideBarState.leftBarState == SideBarStates.collapsed) {
          return MenuItemWidget(
            iconSvgPath: iconSvgPath,
            route: children.first.route,
          );
        }

        return ExpandablePanel(
          controller: controller,
          theme: const ExpandableThemeData(
            hasIcon: false,
            inkWellBorderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          header: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  controller.value = true;
                  context.goNamed(route.name);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: GoRouterState.of(context).fullPath ==
                            GoRouter.of(context).namedLocation(route.name)
                        ? (state.themeMode == ThemeMode.dark
                            ? K.white10
                            : K.black5)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const CustomSvg(
                          svgPath: 'assets/icons/chevron_right.svg',
                          size: 16,
                        ),
                        const LeftBarGap(),
                        CustomSvg(
                          svgPath: iconSvgPath,
                          size: 20,
                        ),
                        const LeftBarGap(),
                        CustomText(
                          route.name,
                          selectable: false,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          collapsed: const SizedBox(),
          expanded: Column(
            children: [
              const LeftBarGap(isVertical: true),
              ...children,
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/logic/cubits/global_observables/global_observables_cubit.dart';
import 'package:management_dashboard/logic/cubits/side_bars/side_bars_cubit.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/app_bar/widgets/app_bar_icon_button.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/app_bar/widgets/appbar_menu_icon.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/click_cursor_on_hover.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

import '../../../../../constants.dart';
import '../../../../widgets/custom_search_bar.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  /// Custom appbar for the dashboard pages
  const CustomAppbar({super.key});

  /// Height of the appbar
  final double appBarHeight = 72;

  @override
  Widget build(BuildContext context) {
    List<CustomRoute> path = AppRoutes.getRoutesFromLocation(
        GoRouterState.of(context).matchedLocation);

    final bool isMobile = MediaQuery.of(context).size.width < K.mobileSize;

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          shape: Border(
            bottom: BorderSide(
              color: themeState.opacity10,
              width: 1,
            ),
          ),
          toolbarHeight: appBarHeight,
          titleTextStyle: const TextStyle(fontSize: 14),
          title: BlocBuilder<GlobalObservablesCubit, GlobalObservablesState>(
            builder: (context, observablesState) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isMobile)
                    AppBarIconButton(
                      svgName: 'left_bar',
                      onPressed: () {
                        if (MediaQuery.of(context).size.width <=
                            K.maxScreenWidth) {
                          BlocProvider.of<SideBarsCubit>(context)
                              .toggleLeftBarForTablet();
                        } else {
                          BlocProvider.of<SideBarsCubit>(context)
                              .toggleDesktopLeftBar();
                        }
                      },
                    ),
                  if (!isMobile)
                    AppBarIconButton(
                      svgName: 'star',
                      onPressed: () {},
                    ),
                  ...List.generate(
                    path.length,
                    (index) => Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (index != 0) const _HelperPathSeparator(),
                          Flexible(
                            child: _HelperPathWidget(
                              text: path[index].displayName ?? path[index].name,
                              enabled: index == path.length - 1 &&
                                  observablesState.appendToPath.isEmpty,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...List.generate(
                    observablesState.appendToPath.length,
                    (index) => Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const _HelperPathSeparator(),
                          Flexible(
                            child: _HelperPathWidget(
                              text: observablesState.appendToPath[index],
                              enabled: index ==
                                  observablesState.appendToPath.length - 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          actions: isMobile
              ? const [
                  AppbarMenuIcon(),
                ]
              : [
                  const CustomSearchBar(
                    hintOpacityColor: OpacityColors.op40,
                    backgroundOpacityColor: OpacityColors.op10,
                  ),
                  const SizedBox(width: 8),
                  AppBarIconButton(
                    svgName: 'sun',
                    onPressed: () {
                      BlocProvider.of<ThemeCubit>(context).switchTheme();
                    },
                  ),
                  AppBarIconButton(
                    svgName: 'clock',
                    onPressed: () {},
                  ),
                  AppBarIconButton(
                    svgName: 'bell',
                    onPressed: () {},
                  ),
                  AppBarIconButton(
                    svgName: 'right_bar',
                    onPressed: () {
                      BlocProvider.of<SideBarsCubit>(context).toggleRightBar();
                    },
                  ),
                  const SizedBox(width: 20),
                ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}

class _HelperPathSeparator extends StatelessWidget {
  /// Helper widget for showing the path separator
  const _HelperPathSeparator();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: CustomText(
        '/',
        opacity: OpacityColors.op20,
      ),
    );
  }
}

class _HelperPathWidget extends StatelessWidget {
  /// Helper widget for showing the path
  const _HelperPathWidget({required this.text, this.enabled = true});

  /// Text to show
  final String text;

  /// Enabled or not
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!enabled) {
          context.goNamed(text);
        }
      },
      child: ClickCursorOnHover(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: CustomText(
            text,
            opacity: enabled ? OpacityColors.op100 : OpacityColors.op40,
            selectable: false,
          ),
        ),
      ),
    );
  }
}

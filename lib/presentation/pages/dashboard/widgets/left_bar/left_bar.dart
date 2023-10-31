import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/data/models/enums/side_bar_states.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/authentication/authentication_cubit.dart';
import 'package:management_dashboard/logic/cubits/global_observables/global_observables_cubit.dart';
import 'package:management_dashboard/logic/cubits/side_bars/side_bars_cubit.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/control_panel/users_management/widgets/user_image_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/app_bar/widgets/app_bar_icon_button.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/left_bar/widgets/expandable_menu_item_widget.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/left_bar/widgets/left_bar_gap.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/left_bar/widgets/menu_item_widget.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_icon_button.dart';
import 'package:management_dashboard/presentation/widgets/custom_divider.dart';
import 'package:management_dashboard/presentation/widgets/dialogs/custom_confirmation_dialog.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class LeftBar extends StatelessWidget {
  /// Left Side bar for the Dashboard Pages
  const LeftBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, authState) {
                  return BlocBuilder<SideBarsCubit, SideBarsState>(
                    builder: (context, state) {
                      if (state.leftBarState == SideBarStates.collapsed) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            UserImageWidget(
                              imageURL: authState.user?.photoURL,
                            ),
                            const Gap16(),
                            const _HelperLogoutButton(),
                          ],
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            UserImageWidget(
                              imageURL: authState.user?.photoURL,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  authState.user?.displayName ?? '?',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ),
                            const _HelperLogoutButton(),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const Gap16(),
              const _HelperHeadingWidget(heading: 'Dashboards'),
              const SizedBox(height: 8),
              Column(
                children: [
                  MenuItemWidget(
                    iconSvgPath: 'assets/icons/overview.svg',
                    route: AppRoutes.dashboardOverviewRoute,
                  ),
                  const LeftBarGap(isVertical: true),
                  BlocBuilder<GlobalObservablesCubit, GlobalObservablesState>(
                    builder: (context, state) {
                      return ExpandableMenuItemWidget(
                        iconSvgPath: 'assets/icons/chart_line.svg',
                        route: AppRoutes.iotPlatformRoute,
                        children: [
                          MenuItemWidget(
                            route: AppRoutes.iotDevicesRoute,
                          ),
                          MenuItemWidget(
                            route: AppRoutes.iotDeviceDetailsRoute,
                            onPressed: () {
                              if (GoRouterState.of(context).fullPath ==
                                  HelperFunctions.getLocationForRoute(context,
                                      AppRoutes.iotDeviceDetailsRoute)) {
                                return;
                              } else {
                                HelperFunctions.showTopCenterToast(
                                    message:
                                        'Kindly, select a device(s) first.');
                                context.goNamed(AppRoutes.iotDevicesRoute.name);
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  const LeftBarGap(isVertical: true),
                  MenuItemWidget(
                    iconSvgPath: 'assets/icons/customer.svg',
                    route: AppRoutes.customersRoute,
                  ),
                  const LeftBarGap(isVertical: true),
                  ExpandableMenuItemWidget(
                    iconSvgPath: 'assets/icons/control_panel.svg',
                    route: AppRoutes.controlPanelRoute,
                    children: [
                      MenuItemWidget(
                        route: AppRoutes.usersManagementRoute,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (MediaQuery.of(context).size.width <= K.mobileSize)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
              ],
            ),
          BlocBuilder<SideBarsCubit, SideBarsState>(
            builder: (context, state) {
              if (state.leftBarState == SideBarStates.open) {
                return SizedBox(
                  height: 65,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/logo.svg',
                      height: 25,
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class _HelperHeadingWidget extends StatelessWidget {
  /// Helper heading widget for the LeftBar
  const _HelperHeadingWidget({required this.heading});

  final String heading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SideBarsCubit, SideBarsState>(
      builder: (context, state) {
        if (state.leftBarState == SideBarStates.collapsed) {
          return const CustomDivider();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CustomText(
            heading,
            opacity: OpacityColors.op40,
          ),
        );
      },
    );
  }
}

class _HelperLogoutButton extends StatelessWidget {
  const _HelperLogoutButton();

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: const Icon(
        Icons.logout_rounded,
        size: 20,
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return CustomConfirmationDialog(
                text: 'Are you sure you want to Logout?',
                onConfirm: () async {
                  await BlocProvider.of<AuthenticationCubit>(context)
                      .signOut()
                      .then((value) {
                    Navigator.pop(context);
                    context.goNamed(AppRoutes.loginRoute.name);
                  });
                },
                onCancel: () {
                  Navigator.pop(context);
                },
              );
            });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/click_cursor_on_hover.dart';
import 'package:management_dashboard/presentation/widgets/custom_container.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/responsive_gap.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/responsive_padding.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';
import 'package:responsive_ui/responsive_ui.dart';

class IoTPlatformLandingPage extends StatefulWidget {
  /// The landing page for the IoT Platform
  const IoTPlatformLandingPage({super.key});

  @override
  State<IoTPlatformLandingPage> createState() => _IoTPlatformLandingPageState();
}

class _IoTPlatformLandingPageState extends State<IoTPlatformLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsivePadding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
        mobilePadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap28(),
              const _HelperHeading(heading: 'Analyze'),
              const Gap16(),
              _HelperWrap(
                children: [
                  _HelperContainer(
                    title: 'IoT Devices',
                    svgPath: 'assets/icons/broadcast.svg',
                    iconSize: 45,
                    onTap: () {
                      context.goNamed(AppRoutes.iotDevicesRoute.name);
                    },
                  ),
                  _HelperContainer(
                    title: 'Data Explorer',
                    svgPath: 'assets/icons/data_explorer.svg',
                    onTap: () {
                      HelperFunctions.showTopCenterToast(
                          message: 'Under Development');
                    },
                  ),
                  _HelperContainer(
                    title: 'Dashboards',
                    svgPath: 'assets/icons/dashboard.svg',
                    onTap: () {
                      HelperFunctions.showTopCenterToast(
                          message: 'Under Development');
                    },
                  ),
                  _HelperContainer(
                    title: 'Device Groups',
                    svgPath: 'assets/icons/device_groups.svg',
                    onTap: () {
                      HelperFunctions.showTopCenterToast(
                          message: 'Under Development');
                    },
                  ),
                ],
              ),
              const Gap28(),
              const _HelperHeading(heading: 'Settings'),
              const Gap16(),
              _HelperWrap(
                children: [
                  _HelperContainer(
                    title: 'Manage Devices',
                    svgPath: 'assets/icons/broadcast.svg',
                    iconSize: 45,
                    onTap: () {
                      context.goNamed(AppRoutes.iotDevicesRoute.name, extra: {
                        'tab': 1,
                      });
                    },
                  ),
                  _HelperContainer(
                    title: 'Device Templates',
                    svgPath: 'assets/icons/device_templates.svg',
                    onTap: () {
                      context.goNamed(AppRoutes.iotDevicesRoute.name, extra: {
                        'tab': 2,
                      });
                    },
                  ),
                  _HelperContainer(
                    title: 'Dashboard Templates',
                    svgPath: 'assets/icons/dashboard_templates.svg',
                    onTap: () {
                      HelperFunctions.showTopCenterToast(
                          message: 'Under Development');
                    },
                  ),
                ],
              ),
              const Gap28(),
              const _HelperHeading(heading: 'Add New Device and Templates'),
              const Gap16(),
              _HelperWrap(
                children: [
                  _HelperContainer(
                    title: 'New IoT Device',
                    svgPath: 'assets/icons/new_iot_device.svg',
                    showAddIcon: true,
                    onTap: () {
                      context.goNamed(AppRoutes.addIotDeviceRoute.name);
                    },
                  ),
                  _HelperContainer(
                    title: 'New Device Template',
                    svgPath: 'assets/icons/new_device_template.svg',
                    showAddIcon: true,
                    onTap: () {
                      context.goNamed(AppRoutes.newIotTemplateRoute.name);
                    },
                  ),
                  _HelperContainer(
                    title: 'New Dashboard Template',
                    svgPath: 'assets/icons/new_dashboard_template.svg',
                    showAddIcon: true,
                    onTap: () {
                      HelperFunctions.showTopCenterToast(
                          message: 'Under Development');
                    },
                  ),
                ],
              ),
              const Gap28(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HelperHeading extends StatelessWidget {
  /// A helper heading for the IoT Platform Landing Page
  const _HelperHeading({required this.heading});

  /// The heading of the helper container
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: CustomText(
        heading,
        style: K.headingStyleDashboard.copyWith(fontSize: 16),
      ),
    );
  }
}

class _HelperContainer extends StatefulWidget {
  /// A helper container for the IoT Platform Landing Page
  const _HelperContainer({
    required this.title,
    required this.svgPath,
    this.iconSize,
    this.onTap,
    this.showAddIcon = false,
  });

  /// The title of the container
  final String title;

  /// The svg path of the icon
  final String svgPath;

  /// The size of the icon
  final double? iconSize;

  /// On tap callback
  final VoidCallback? onTap;

  /// Whether to show the add icon or not
  final bool showAddIcon;

  @override
  State<_HelperContainer> createState() => _HelperContainerState();
}

class _HelperContainerState extends State<_HelperContainer> {
  /// Whether the tile is hovered or not
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return ClickCursorOnHover(
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (event) {
          setState(() {
            hovered = false;
          });
        },
        child: GestureDetector(
          onTap: widget.onTap,
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 130),
                child: CustomContainer(
                  borderRadius: BorderRadius.circular(8),
                  width: 250,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  staticBackgroundColor: hovered
                      ? state.themeMode == ThemeMode.dark
                          ? K.white10
                          : K.blueE0EEF4
                      : null,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const Gap16(),
                      CustomText(
                        widget.title,
                        selectable: false,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const ResponsiveGap(mobileGap: 15, desktopGap: 20),
                      CustomSvg(
                        svgPath: widget.svgPath,
                        size: widget.iconSize ?? 40,
                      ),
                      if (widget.showAddIcon)
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: CustomSvg(
                            svgPath: 'assets/icons/add_iot_platform.svg',
                            opacity: OpacityColors.op40,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HelperWrap extends StatelessWidget {
  /// A helper wrap for the IoT Platform Landing Page
  const _HelperWrap({
    required this.children,
  });

  /// The children of the wrap
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Responsive(
      runSpacing: 20,
      children: children
          .map(
            (e) => Div(
              divison: const Division(colXS: 12, colM: 6, colL: 4, colXL: 3),
              child: e,
            ),
          )
          .toList(),
    );
  }
}

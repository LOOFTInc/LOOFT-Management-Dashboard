import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/data/models/enums/side_bar_states.dart';
import 'package:management_dashboard/logic/cubits/global_observables/global_observables_cubit.dart';
import 'package:management_dashboard/logic/cubits/side_bars/side_bars_cubit.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/app_bar/custom_appbar.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/left_bar/left_bar.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/right_bar/right_bar.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/version_features_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../constants.dart';

class DashboardPage extends StatefulWidget {
  /// Dashboard Page (Shell route)
  /// Generates side bars around the child widget
  const DashboardPage({
    super.key,
    required this.child,
  });

  /// Child widget
  final Widget child;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();

    checkVersionAndShowDialog();
  }

  /// Checks the version and shows a dialog if the version has changed
  void checkVersionAndShowDialog() {
    PackageInfo.fromPlatform().then((value) {
      String currentVersion = value.version;

      String? savedVersion =
          BlocProvider.of<GlobalObservablesCubit>(context).state.savedVersion;

      if (savedVersion != currentVersion) {
        showDialog(
          context: context,
          builder: (context) => const VersionFeaturesDialog(),
        );

        BlocProvider.of<GlobalObservablesCubit>(context)
            .setSavedVersion(currentVersion);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<SideBarsCubit>(context).state;
    if (MediaQuery.of(context).size.width <= K.mobileSize) {
      BlocProvider.of<SideBarsCubit>(context).hideLeftBar();
    }

    if (MediaQuery.of(context).size.width <= K.mobileSize) {
      return Scaffold(
        appBar: const CustomAppbar(),
        body: Stack(
          children: [
            widget.child,
            BlocBuilder<SideBarsCubit, SideBarsState>(
              builder: (context, state) {
                if (state.leftBarState == SideBarStates.open) {
                  return const LeftBar();
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      );
    }

    if (MediaQuery.of(context).size.width <= K.maxScreenWidth) {
      if (state.leftBarState == SideBarStates.open) {
        BlocProvider.of<SideBarsCubit>(context).collapseLeftBar();
      }
    } else {
      if (state.leftBarState == SideBarStates.collapsed) {
        BlocProvider.of<SideBarsCubit>(context).showLeftBar();
      }
    }

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SideBarsCubit, SideBarsState>(
            builder: (context, state) {
              if (state.leftBarState == SideBarStates.closed) {
                return const SizedBox();
              }

              return SizedBox(
                width: state.leftBarState == SideBarStates.open ? 280 : 72,
                child: const LeftBar(),
              );
            },
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return VerticalDivider(
                width: 1,
                thickness: 1,
                color: state.opacity10,
              );
            },
          ),
          Flexible(
            child: Scaffold(
              appBar: const CustomAppbar(),
              body: widget.child,
            ),
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return VerticalDivider(
                width: 1,
                thickness: 1,
                color: state.opacity10,
              );
            },
          ),
          BlocBuilder<SideBarsCubit, SideBarsState>(
            builder: (context, state) {
              if (state.rightBarState != SideBarStates.open ||
                  MediaQuery.of(context).size.width <= K.maxScreenWidth) {
                return const SizedBox();
              }

              return const SizedBox(
                width: 280,
                child: RightBar(),
              );
            },
          ),
        ],
      ),
    );
  }
}

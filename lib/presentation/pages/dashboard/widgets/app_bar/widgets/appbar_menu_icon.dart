import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/data/models/enums/side_bar_states.dart';
import 'package:management_dashboard/logic/cubits/side_bars/side_bars_cubit.dart';

class AppbarMenuIcon extends StatefulWidget {
  /// Appbar menu icon
  const AppbarMenuIcon({super.key});

  @override
  State<AppbarMenuIcon> createState() => _AppbarMenuIconState();
}

class _AppbarMenuIconState extends State<AppbarMenuIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SideBarsCubit, SideBarsState>(
      builder: (context, state) {
        if (state.leftBarState == SideBarStates.closed) {
          if (controller.status == AnimationStatus.completed) {
            controller.reverse();
          }
        } else if (state.leftBarState == SideBarStates.open) {
          controller.forward();
        }

        return IconButton(
          onPressed: () {
            BlocProvider.of<SideBarsCubit>(context).toggleLeftBarForMobile();
            if (controller.status == AnimationStatus.completed) {
              controller.reverse();
              return;
            }

            controller.forward();
          },
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animation,
          ),
        );
      },
    );
  }
}

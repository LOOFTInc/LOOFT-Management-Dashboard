import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';

class AppBarIconButton extends StatelessWidget {
  /// Icon button for the appbar
  const AppBarIconButton({
    super.key,
    this.svgPath,
    this.onPressed,
    this.svgName,
  });

  /// Name of the svg icon
  final String? svgName;

  /// Path to the svg icon
  final String? svgPath;

  /// On Pressed Callback
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    assert(svgName != null || svgPath != null);

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return IconButton(
          onPressed: onPressed,
          icon: CustomSvg(
            svgPath: svgPath ?? 'assets/icons/$svgName.svg',
            size: 20,
          ),
        );
      },
    );
  }
}

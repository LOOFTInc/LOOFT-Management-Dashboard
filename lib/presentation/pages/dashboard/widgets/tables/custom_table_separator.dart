import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/enums/opacity_colors.dart';
import '../../../../../logic/cubits/theme/theme_cubit.dart';

class CustomTableSeparator extends StatelessWidget {
  /// Custom Table Separator Widget with Theme Support.
  const CustomTableSeparator({super.key, this.opacity});

  /// Opacity of the separator
  final OpacityColors? opacity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          height: 1,
          color: opacity?.getColorFromThemeState(state) ?? state.opacity5,
        );
      },
    );
  }
}

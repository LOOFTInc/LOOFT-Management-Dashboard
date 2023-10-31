import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../logic/cubits/theme/theme_cubit.dart';

class TableGradientDivider extends StatelessWidget {
  /// Custom Table Gradient Divider Widget with Theme Support.
  ///
  /// Used to show the dividers between the table cells in the header
  const TableGradientDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          height: 47,
          width: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                state.opacity10,
              ],
              stops: const [0.0, 0.5],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
      },
    );
  }
}

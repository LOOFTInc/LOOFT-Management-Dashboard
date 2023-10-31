import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/widgets/custom_container.dart';
import 'package:management_dashboard/presentation/widgets/custom_search_bar.dart';

class TableFunctionBar extends StatelessWidget {
  /// Function bar for ListViews
  const TableFunctionBar({
    super.key,
    this.onSearch,
  });

  /// Function to be called when searching
  final Function(String)? onSearch;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [],
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return CustomSearchBar(
                hintOpacityColor: OpacityColors.op20,
                backgroundOpacityColor: state.themeMode == ThemeMode.dark
                    ? OpacityColors.op5
                    : OpacityColors.rop80,
                borderOpacityColor: OpacityColors.op10,
                searchFunction: onSearch,
              );
            },
          ),
        ],
      ),
    );
  }
}

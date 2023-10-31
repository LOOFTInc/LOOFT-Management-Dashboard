import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    this.searchFunction,
    required this.hintOpacityColor,
    required this.backgroundOpacityColor,
    this.borderOpacityColor,
  });

  /// Search function to be called when the user types
  final Function(String)? searchFunction;

  /// Opacity color of the hint text
  final OpacityColors hintOpacityColor;

  /// Opacity color of the background fill
  final OpacityColors backgroundOpacityColor;

  /// Opacity color of the border
  final OpacityColors? borderOpacityColor;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  /// Debounce timer for the search function
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 28,
                decoration: BoxDecoration(
                  color: widget.backgroundOpacityColor
                      .getColorFromThemeState(state),
                  borderRadius: BorderRadius.circular(8),
                  border: widget.borderOpacityColor != null
                      ? Border.all(
                          color: widget.borderOpacityColor!
                              .getColorFromThemeState(state),
                          width: 1,
                        )
                      : null,
                ),
              ),
              TextField(
                onChanged: (value) {
                  if (widget.searchFunction == null) return;

                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 300), () {
                    widget.searchFunction!(value);
                  });
                },
                style: const TextStyle(
                  height: 16 / 14,
                  fontSize: 14,
                ),
                cursorHeight: 16,
                cursorColor:
                    widget.hintOpacityColor.getColorFromThemeState(state),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color:
                        widget.hintOpacityColor.getColorFromThemeState(state),
                    fontSize: 14,
                  ),
                  prefixIcon: const CustomSvg(
                    svgPath: 'assets/icons/search.svg',
                    size: 16,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    maxHeight: 20,
                    minWidth: 26,
                  ),
                  filled: false,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/left_bar/widgets/left_bar_gap.dart';

import '../../../../../../logic/cubits/theme/theme_cubit.dart';
import '../../../../../widgets/text_widgets/custom_text.dart';

class LeftBarFavoritesList extends StatelessWidget {
  /// Favorites List for the Left Bar
  const LeftBarFavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HelperWidget(
          text: 'Overview',
          onPressed: () {},
        ),
        _HelperWidget(
          text: 'Analytics',
          onPressed: () {},
        ),
      ],
    );
  }
}

class _HelperWidget extends StatelessWidget {
  /// Helper Widget for the Left Bar Favorites List
  const _HelperWidget({
    required this.text,
    required this.onPressed,
  });

  /// Text for the Helper Widget
  final String text;

  /// Function to call when the Helper Widget is pressed
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.circle,
                  color: state.opacity20,
                  size: 8,
                ),
              ),
              const LeftBarGap(),
              Flexible(
                child: CustomText(
                  text,
                  selectable: false,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

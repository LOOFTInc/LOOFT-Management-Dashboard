import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/responsive_padding.dart';

import '../../../../logic/cubits/theme/theme_cubit.dart';
import '../../../widgets/gaps_and_paddings/horizontal_padding.dart';
import 'copyright.dart';

class AuthPagesBuilder extends StatelessWidget {
  /// Builder widget for authentication related pages
  const AuthPagesBuilder({
    super.key,
    required this.child,
    this.maxCardWidth = 680,
    this.minCardHeight = 652,
    this.horizontalPadding = 145,
    this.mobileHorizontalPadding = 30,
  });

  /// Child widget
  final Widget child;

  /// Minimum Card Width
  final double maxCardWidth;

  /// Minimum Card Height
  final double minCardHeight;

  /// Horizontal padding inside the card
  final double horizontalPadding;

  /// Mobile Horizontal padding inside the card
  final double mobileHorizontalPadding;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          body: HorizontalPadding(
            padding: 48,
            mobilePadding: 16,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: maxCardWidth,
                        minHeight: minCardHeight,
                      ),
                      child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ResponsivePadding(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding, vertical: 48),
                          mobilePadding: EdgeInsets.symmetric(
                              horizontal: mobileHorizontalPadding,
                              vertical: 48),
                          child: child,
                        ),
                      ),
                    ),
                    const Copyright(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

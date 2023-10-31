import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/routing/app_routes.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

import '../../../../constants.dart';

class Copyright extends StatelessWidget {
  const Copyright({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return CustomText(
                '© ${DateTime.now().year} LOOFT Inc.',
                style: TextStyle(
                  color: GoRouterState.of(context).matchedLocation ==
                          AppRoutes.loginRoute
                      ? K.white40
                      : state.opacity40,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

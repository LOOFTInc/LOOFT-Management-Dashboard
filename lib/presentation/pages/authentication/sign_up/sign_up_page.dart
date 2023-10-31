import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/authentication/sign_up/widgets/sign_up_card_content.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/auth_pages_builder.dart';

class SignUpPage extends StatelessWidget {
  /// The sign up page for the app
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return const AuthPagesBuilder(
            child: SignUpCardContent(),
          );
        },
      ),
    );
  }
}

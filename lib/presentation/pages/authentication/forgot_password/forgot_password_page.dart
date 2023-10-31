import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/auth_pages_builder.dart';

import 'widgets/forgot_password_card_content.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPagesBuilder(child: ForgotPasswordCardContent());
  }
}

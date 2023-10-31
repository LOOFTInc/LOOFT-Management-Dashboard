import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/authentication/two_step_verification/widgets/two_step_verification_card_content.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/auth_pages_builder.dart';
import 'package:management_dashboard/presentation/widgets/locked_for_production.dart';

class TwoStepVerificationPage extends StatelessWidget {
  const TwoStepVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LockedForProduction(
      child: AuthPagesBuilder(child: TwoStepVerificationCardContent()),
    );
  }
}

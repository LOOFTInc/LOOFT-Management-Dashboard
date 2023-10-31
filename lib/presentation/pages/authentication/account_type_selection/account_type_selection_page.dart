import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/authentication/account_type_selection/widgets/account_type_selection_card_content.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/auth_pages_builder.dart';
import 'package:management_dashboard/presentation/widgets/locked_for_production.dart';

class AccountTypeSelectionPage extends StatelessWidget {
  /// Page for selecting account type
  const AccountTypeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LockedForProduction(
      child: AuthPagesBuilder(
        maxCardWidth: 986,
        minCardHeight: 388,
        horizontalPadding: 48,
        child: AccountTypeSelectionCardContent(),
      ),
    );
  }
}

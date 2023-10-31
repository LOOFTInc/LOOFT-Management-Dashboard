import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/authentication/company_selection/widgets/company_selection_card_content.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/auth_pages_builder.dart';

class CompanySelectionPage extends StatelessWidget {
  /// Page for selecting the company
  const CompanySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPagesBuilder(
      maxCardWidth: 986,
      minCardHeight: 388,
      horizontalPadding: 48,
      child: CompanySelectionCardContent(),
    );
  }
}

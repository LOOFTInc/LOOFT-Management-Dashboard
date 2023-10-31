import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/authentication/auth_actions/widgets/auth_actions_error_widget.dart';
import 'package:management_dashboard/presentation/pages/authentication/auth_actions/widgets/setup_new_password_card_content.dart';
import 'package:management_dashboard/presentation/pages/authentication/widgets/auth_pages_builder.dart';

class AuthActionsPage extends StatefulWidget {
  /// The setup new password page
  const AuthActionsPage({
    super.key,
    required this.queryParams,
  });

  /// The Password reset code
  final Map<String, String> queryParams;

  @override
  State<AuthActionsPage> createState() => _AuthActionsPageState();
}

class _AuthActionsPageState extends State<AuthActionsPage> {
  /// The mode of authentication query
  late final String? mode = widget.queryParams['mode'];

  /// The reset password mode
  final String _resetPasswordMode = 'resetPassword';

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (mode == _resetPasswordMode && widget.queryParams['oobCode'] != null) {
      child = SetupNewPasswordCardContent(code: widget.queryParams['oobCode']!);
    } else {
      child = const AuthActionsErrorWidget(
        errorMessage:
            'Seems like you have stumbled upon the wrong page. Kindly go back.',
      );
    }

    return AuthPagesBuilder(
      child: child,
    );
  }
}

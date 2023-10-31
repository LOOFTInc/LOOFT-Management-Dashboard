import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/widgets/buttons/rounded_text_button.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class CustomConfirmationDialog extends StatelessWidget {
  /// Custom Confirmation Dialog
  const CustomConfirmationDialog({
    super.key,
    this.text,
    this.onConfirm,
    this.onCancel,
  });

  /// Text to show in the dialog
  final String? text;

  /// Function to execute when the user confirms
  final VoidCallback? onConfirm;

  /// Function to execute when the user cancels
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Flexible(
            child: CustomText(
              text ?? 'Are you sure?',
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
      actions: [
        RoundedTextButton(
          onPressed: onConfirm,
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.green),
          ),
        ),
        RoundedTextButton(
          onPressed: onCancel,
          child: const Text(
            'No',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}

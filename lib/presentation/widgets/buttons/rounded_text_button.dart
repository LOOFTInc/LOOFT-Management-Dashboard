import 'package:flutter/material.dart';

class RoundedTextButton extends StatefulWidget {
  /// Rounded Text Button with Corners radius of 8
  const RoundedTextButton({super.key, this.onPressed, required this.child});

  /// On Pressed callback
  final Function()? onPressed;

  /// Child widget
  final Widget child;

  @override
  State<RoundedTextButton> createState() => _RoundedTextButtonState();
}

class _RoundedTextButtonState extends State<RoundedTextButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (widget.onPressed == null || loading) {
          return;
        }

        setState(() {
          loading = true;
        });
        await widget.onPressed!();
        setState(() {
          loading = false;
        });
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: loading
          ? const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            )
          : widget.child,
    );
  }
}

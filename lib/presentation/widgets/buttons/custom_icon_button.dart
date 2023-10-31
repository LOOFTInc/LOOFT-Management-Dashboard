import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  /// A custom icon button
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
  });

  /// Size of the icon
  final Widget icon;

  /// Callback for when the button is pressed
  final Function()? onPressed;

  /// Tooltip for the button
  final String? tooltip;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: widget.tooltip,
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
      icon: loading
          ? const SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            )
          : widget.icon,
    );
  }
}

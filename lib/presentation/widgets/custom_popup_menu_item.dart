import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class CustomPopupMenuItem extends StatefulWidget implements PopupMenuEntry {
  /// A custom popup menu item
  const CustomPopupMenuItem({
    super.key,
    required this.child,
    this.onTap,
    this.enabled = true,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// On tap callback
  final VoidCallback? onTap;

  final bool enabled;

  @override
  State<CustomPopupMenuItem> createState() => _CustomPopupMenuItemState();

  @override
  double get height => 40;

  @override
  bool represents(value) {
    throw UnimplementedError();
  }
}

class _CustomPopupMenuItemState extends State<CustomPopupMenuItem> {
  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: PopupMenuItem(
        height: 40,
        onTap: widget.onTap,
        enabled: widget.enabled,
        child: widget.child,
      ),
    );
  }
}

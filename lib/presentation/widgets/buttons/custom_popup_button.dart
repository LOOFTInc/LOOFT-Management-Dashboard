import 'package:flutter/material.dart';

class CustomPopupButton extends StatelessWidget {
  /// Custom popup button
  const CustomPopupButton({super.key, required this.items});

  /// List of items to be displayed in the popup menu
  final List<PopupMenuEntry> items;

  @override
  Widget build(BuildContext context) {
    return PopupMenuTheme(
      data: const PopupMenuThemeData(
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      child: PopupMenuButton(
        tooltip: '',
        position: PopupMenuPosition.under,
        icon: const Icon(Icons.more_horiz),
        iconSize: 20,
        itemBuilder: (context) => items,
      ),
    );
  }
}

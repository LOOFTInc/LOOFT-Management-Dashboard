import 'package:flutter/cupertino.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_popup_button.dart';
import 'package:management_dashboard/presentation/widgets/custom_popup_menu_item.dart';

class TableListTileMenuButton extends StatelessWidget {
  /// Menu Button shown at the end of each table list tile
  const TableListTileMenuButton({
    super.key,
    this.onEdit,
  });

  /// Edit Page
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return CustomPopupButton(items: [
      if (onEdit != null)
        CustomPopupMenuItem(
          onTap: onEdit,
          child: const Text('Edit'),
        ),
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/table_list_tile_menu_button.dart';

import '../../../../../constants.dart';
import '../../../../widgets/custom_check_box.dart';

class TableListTile extends StatefulWidget {
  /// Custom Table List Tile
  const TableListTile({
    super.key,
    required this.content,
    this.onDoubleTap,
    this.onEdit,
    this.tileColor,
  });

  /// Content of the tile
  final Widget content;

  /// On tap callback
  final VoidCallback? onDoubleTap;

  final VoidCallback? onEdit;

  /// Tile color
  final Color? tileColor;

  @override
  State<TableListTile> createState() => _TableListTileState();
}

class _TableListTileState extends State<TableListTile> {
  /// Whether the tile is selected or not
  bool selected = false;

  /// Whether the tile is hovered or not
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MouseRegion(
          onEnter: (event) {
            setState(() {
              hovered = true;
            });
          },
          onExit: (event) {
            setState(() {
              hovered = false;
            });
          },
          child: GestureDetector(
            onDoubleTap: widget.onDoubleTap,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              mouseCursor: SystemMouseCursors.click,
              tileColor: hovered
                  ? state.themeMode == ThemeMode.dark
                      ? K.white5
                      : K.blueE0EEF4
                  : widget.tileColor,
              leading: CustomCheckBox(
                value: selected,
                onChanged: (value) {
                  setState(() {
                    selected = value ?? false;
                  });
                },
              ),
              trailing: TableListTileMenuButton(
                onEdit: widget.onEdit,
              ),
              title: widget.content,
            ),
          ),
        );
      },
    );
  }
}

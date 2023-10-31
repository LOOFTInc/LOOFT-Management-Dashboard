import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/table_gradient_divider.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/tables/table_list_tile_menu_button.dart';
import 'package:management_dashboard/presentation/widgets/custom_svg.dart';

import '../../../../../data/models/enums/opacity_colors.dart';
import '../../../../widgets/custom_check_box.dart';
import '../../models/table_column.dart';
import 'custom_table_column.dart';
import 'custom_table_separator.dart';

class TableHeader extends StatelessWidget {
  /// Table Header Widget
  const TableHeader({
    super.key,
    required this.columns,
    required this.onCheckAll,
    this.sortingIndex,
  });

  /// List of columns
  final List<TableColumn> columns;

  /// On Check All callback
  final Function(bool?) onCheckAll;

  /// Sorting Index
  final int? sortingIndex;

  @override
  Widget build(BuildContext context) {
    String? svgPath;

    if (sortingIndex != null) {
      if (sortingIndex! < 0) {
        svgPath = 'assets/icons/arrow_down.svg';
      } else {
        svgPath = 'assets/icons/arrow_up.svg';
      }
    }

    return Column(
      children: [
        ListTile(
          minVerticalPadding: 0,
          leading: CustomCheckBox(
            value: false,
            onChanged: onCheckAll,
          ),
          trailing: const IgnorePointer(
            child: Opacity(
              opacity: 0,
              child: TableListTileMenuButton(),
            ),
          ),
          title: SizedBox(
            height: 48,
            child: Row(
              children: [
                ...List.generate(columns.length * 2 - 1, (listIndex) {
                  final int valueIndex = listIndex ~/ 2;
                  if (listIndex % 2 != 0) {
                    return const TableGradientDivider();
                  }

                  return Expanded(
                    flex: columns[valueIndex].flex,
                    child: TextButton(
                      onPressed: columns[valueIndex].onTap,
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.zero,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: CustomTableColumn(
                        text: columns[valueIndex].title,
                        opacity: OpacityColors.op40,
                        selectable: false,
                        trailing: valueIndex + 1 == sortingIndex?.abs()
                            ? CustomSvg(
                                svgPath: svgPath!,
                                opacity: OpacityColors.op40,
                              )
                            : null,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        const CustomTableSeparator(
          opacity: OpacityColors.op20,
        ),
      ],
    );
  }
}

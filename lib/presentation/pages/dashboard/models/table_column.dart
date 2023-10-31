import 'package:flutter/material.dart';

/// Custom Table Column
class TableColumn {
  /// Title of the column
  final String title;

  /// Flex of the column
  final int flex;

  /// On Tap callback
  VoidCallback? onTap;

  TableColumn({
    required this.title,
    required this.flex,
    this.onTap,
  });
}

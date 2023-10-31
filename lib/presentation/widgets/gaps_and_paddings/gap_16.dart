import 'package:flutter/material.dart';

import '../../../constants.dart';

class Gap16 extends StatelessWidget {
  /// A gap widget - gap is 16px vertically by default
  /// can be set to be horizontal
  const Gap16({
    super.key,
    this.isHorizontal = false,
    this.changeForMobile = true,
  });

  /// Whether the gap is horizontal or vertical
  final bool isHorizontal;

  /// Where the gap should be changed for mobile
  final bool changeForMobile;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = changeForMobile
        ? MediaQuery.of(context).size.width < K.mobileSize
        : false;

    return SizedBox(
      height: isHorizontal
          ? 0
          : isMobile
              ? 10
              : 16,
      width: isHorizontal
          ? isMobile
              ? 10
              : 16
          : 0,
    );
  }
}

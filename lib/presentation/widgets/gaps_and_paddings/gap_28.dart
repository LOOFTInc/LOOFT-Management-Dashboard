import 'package:flutter/material.dart';

import '../../../constants.dart';

class Gap28 extends StatelessWidget {
  /// A gap widget - gap is 28px vertically by default
  /// can be set to be horizontal
  const Gap28({
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
              ? K.gap28Mobile
              : K.gap28Desktop,
      width: isHorizontal
          ? isMobile
              ? K.gap28Mobile
              : K.gap28Desktop
          : 0,
    );
  }
}

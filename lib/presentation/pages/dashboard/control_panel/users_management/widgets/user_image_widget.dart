import 'package:flutter/material.dart';

class UserImageWidget extends StatelessWidget {
  /// User Image Widget
  const UserImageWidget({
    super.key,
    this.imageURL,
  });

  /// Image URL
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    if (imageURL != null) {
      return Image.network(
        imageURL!,
        height: 24,
        width: 24,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/user_small.png',
            width: 24,
            height: 24,
          );
        },
      );
    }

    return Image.asset(
      'assets/images/user_small.png',
      width: 24,
      height: 24,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/presentation/widgets/click_cursor_on_hover.dart';
import 'package:management_dashboard/presentation/widgets/custom_container.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/responsive_padding.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';
import 'package:responsive_ui/responsive_ui.dart';

class CompanyWidget extends StatelessWidget {
  /// Widget for each Company in the [CompanySelectionPage]
  const CompanyWidget({
    super.key,
    required this.isSelected,
    this.imagePath,
    required this.name,
    this.onPressed,
  });

  /// Whether the account type is selected or not
  final bool isSelected;

  /// SVG Path of the account type image
  final String? imagePath;

  /// Account type name
  final String name;

  /// Callback when the widget is pressed
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Div(
      divison: const Division(
        colS: 12,
        colM: 6,
        colL: 4,
      ),
      child: ResponsivePadding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: ClickCursorOnHover(
          child: GestureDetector(
            onTap: onPressed,
            child: CustomContainer(
              width: 270,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? K.primaryBlue : Colors.transparent,
                width: 2,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Image.network(
                      imagePath ?? '',
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset('assets/images/company.png'),
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : const CircularProgressIndicator(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Center(
                      child: CustomText(
                        name,
                        selectable: false,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

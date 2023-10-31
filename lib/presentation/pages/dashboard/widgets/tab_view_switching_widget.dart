import 'package:flutter/material.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

import '../../../../constants.dart';
import '../../../../data/models/enums/opacity_colors.dart';

class TabViewSwitchingWidget extends StatefulWidget {
  /// Widget for switching between tabs in the dashboard
  const TabViewSwitchingWidget({
    super.key,
    required this.tabs,
    required this.tabController,
  });

  /// List of tabs to be displayed
  final List<String> tabs;

  /// Tab controller for the tab view
  final TabController tabController;

  @override
  State<TabViewSwitchingWidget> createState() => _TabViewSwitchingWidgetState();
}

class _TabViewSwitchingWidgetState extends State<TabViewSwitchingWidget> {
  @override
  void initState() {
    super.initState();

    widget.tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.tabs
          .map(
            (e) => _HelperButton(
              text: e,
              selected: widget.tabController.index == widget.tabs.indexOf(e),
              onPressed: () {
                setState(() {
                  widget.tabController.animateTo(
                    widget.tabs.indexOf(e),
                  );
                });
              },
            ),
          )
          .toList(),
    );
  }
}

class _HelperButton extends StatelessWidget {
  /// Helper button for the tab view switching widget
  const _HelperButton({
    required this.text,
    required this.selected,
    this.onPressed,
  });

  /// Text to be displayed in the button
  final String text;

  /// Whether the button is selected or not
  final bool selected;

  /// Callback to be called when the button is pressed
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? K.primaryBlue : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        padding: const EdgeInsets.only(bottom: 2),
        child: CustomText(
          text,
          selectable: false,
          opacity: OpacityColors.op40,
          staticColor: selected ? K.primaryBlue : null,
        ),
      ),
    );
  }
}

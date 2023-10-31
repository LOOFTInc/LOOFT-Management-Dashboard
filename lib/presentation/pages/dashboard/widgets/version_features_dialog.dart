import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_icon_button.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_16.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/gap_28.dart';
import 'package:management_dashboard/presentation/widgets/gaps_and_paddings/responsive_padding.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';

class VersionFeaturesDialog extends StatefulWidget {
  /// Dialog that shows the new features of the new version
  const VersionFeaturesDialog({super.key});

  @override
  State<VersionFeaturesDialog> createState() => _VersionFeaturesDialogState();
}

class _VersionFeaturesDialogState extends State<VersionFeaturesDialog> {
  /// The new features of the new version
  List<String> newFeatures = [
    'You can now search the address of a Device instead of needing to add Latitude and Longitude when adding/editing a Device.',
    'There are now two Graphs in the Device Details Page, so you can easily compare different Capabilities of your IoT Devices.',
    'We have a New Landing Page for IoT Platform allowing you to navigate quickly.',
  ];

  /// The improvements of the new version
  List<String> improvements = [
    'You can now toggle Graph Zoom Behavior on/off to allow for smooth scrolling.',
    'Graph improvements with new Date Formats for x-axis and tooltip.',
    'Now you can see the MAC Address and Status of your device on device details page.',
    'Added option to remove Device Capabilities.',
  ];

  /// The bug fixes of the new version
  List<String> bugFixes = [];

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width <= K.mobileSize;

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Dialog(
          insetPadding: isMobile
              ? const EdgeInsets.all(20)
              : const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: state.reverseOpacity100,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomIconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ResponsivePadding(
                      mobilePadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CustomText(
                              'New Updates and Features',
                              style: K.headingStyleDashboard,
                            ),
                            _HelperListBuilder(
                              list: newFeatures,
                              title: 'New Features',
                            ),
                            _HelperListBuilder(
                              list: improvements,
                              title: 'Improvements',
                            ),
                            _HelperListBuilder(
                              list: bugFixes,
                              title: 'Bug Fixes',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HelperListBuilder extends StatelessWidget {
  /// Helper widget for the version features dialog
  const _HelperListBuilder({
    required this.list,
    required this.title,
  });

  /// The list of the features
  final List<String> list;

  /// The title of the list
  final String title;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) return const SizedBox();

    return Column(
      children: [
        const Gap28(
          changeForMobile: false,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              '$title:',
              style: const TextStyle(color: K.primaryBlue),
            ),
            const Gap16(),
            ...List.generate(
              list.length,
              (index) => _HelperNumberedText(
                index: index + 1,
                text: list.elementAt(index),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HelperNumberedText extends StatelessWidget {
  /// Helper widget for the version features dialog
  const _HelperNumberedText({required this.index, required this.text});

  /// The index of the text
  final int index;

  /// The text
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomText(
              '$index. ',
              opacity: OpacityColors.op50,
            ),
          ),
          Flexible(
            child: CustomText(
              text,
              opacity: OpacityColors.op50,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

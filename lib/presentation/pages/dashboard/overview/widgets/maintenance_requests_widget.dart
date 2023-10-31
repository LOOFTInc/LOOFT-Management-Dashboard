import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../../../../widgets/text_widgets/custom_text.dart';

class MaintenanceRequestsWidget extends StatelessWidget {
  /// Widget to show the maintenance requests on the overview page
  const MaintenanceRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 202,
      height: 320,
      decoration: BoxDecoration(
        color: K.pinkFFDEDE,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.fromLTRB(24, 24, 10, 24),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Maintenance Requests',
            style: TextStyle(fontWeight: FontWeight.w600),
            staticColor: K.black,
          ),
          SizedBox(height: 17),
          CustomText('Total Requests', staticColor: K.black),
          _HelperSpacingWidget(),
          CustomText(
            '100',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            staticColor: K.black,
          ),
          _HelperSpacingWidget(),
          CustomText('In progress', staticColor: K.black),
          _HelperSpacingWidget(),
          CustomText(
            '3',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            staticColor: K.black,
          ),
          _HelperSpacingWidget(),
          CustomText('Remaining', staticColor: K.black),
          _HelperSpacingWidget(),
          CustomText(
            '10',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            staticColor: K.black,
          ),
          _HelperSpacingWidget(),
          CustomText('Completed', staticColor: K.black),
          _HelperSpacingWidget(),
          CustomText(
            '87',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            staticColor: K.black,
          ),
        ],
      ),
    );
  }
}

class _HelperSpacingWidget extends StatelessWidget {
  const _HelperSpacingWidget();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 7);
  }
}

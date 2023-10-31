import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';

import '../../../../../constants.dart';
import '../../../../widgets/text_widgets/custom_text.dart';

class DashboardFormFieldContainer extends StatefulWidget {
  /// Container for Dashboard Form Fields
  ///
  /// Adds Label to the Form Field & handles border change on focus
  const DashboardFormFieldContainer({
    super.key,
    required this.focusNode,
    this.label,
    required this.formField,
    this.lessPadding = false,
  });

  /// The focus node of the text field
  final FocusNode focusNode;

  /// The label of the text field
  final String? label;

  /// The form field widget
  final Widget formField;

  /// If there is a button in the form field, use less padding
  final bool lessPadding;

  @override
  State<DashboardFormFieldContainer> createState() =>
      _DashboardFormFieldContainerState();
}

class _DashboardFormFieldContainerState
    extends State<DashboardFormFieldContainer> {
  @override
  void initState() {
    super.initState();

    widget.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final double padding = widget.lessPadding ? 10 : 20;

        return Container(
          padding: widget.label != null
              ? EdgeInsets.fromLTRB(padding, 16, padding, 6)
              : EdgeInsets.fromLTRB(padding, 4, padding, 6),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(
              color:
                  widget.focusNode.hasFocus ? state.opacity40 : state.opacity10,
            ),
            color: K.white5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label != null)
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.lessPadding ? 10 : 0),
                  child: CustomText(
                    widget.label!,
                    style: TextStyle(
                      color: state.opacity40,
                      fontSize: 12,
                    ),
                  ),
                ),
              widget.formField,
            ],
          ),
        );
      },
    );
  }
}

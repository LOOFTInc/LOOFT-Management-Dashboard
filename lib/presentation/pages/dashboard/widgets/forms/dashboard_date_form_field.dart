import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_form_field_container.dart';

import '../../../../../../../logic/cubits/theme/theme_cubit.dart';

class DashboardDateFormField extends StatefulWidget {
  /// Date Time Picker Form Field
  const DashboardDateFormField({
    super.key,
    required this.name,
    this.validator,
    this.onChanged,
    this.label,
    this.initialValue,
    this.enabled = true,
  });

  /// The Label of the text field
  final String? label;

  /// The name of the text field
  final String name;

  /// The validator of the text field
  final String? Function(DateTime?)? validator;

  /// The onChanged of the text field
  final Function(DateTime?)? onChanged;

  /// The initial value of the Date time picker
  final DateTime? initialValue;

  /// Whether the field is enabled or not
  final bool enabled;

  @override
  State<DashboardDateFormField> createState() => _DashboardDateFormFieldState();
}

class _DashboardDateFormFieldState extends State<DashboardDateFormField> {
  /// The focus node of the text field
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return DashboardFormFieldContainer(
          focusNode: _focusNode,
          label: widget.label,
          formField: DatePickerTheme(
            data: DatePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: FormBuilderDateTimePicker(
              style: const TextStyle(fontSize: 14),
              name: 'date',
              focusNode: _focusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              initialEntryMode: DatePickerEntryMode.calendar,
              initialValue: widget.initialValue ??
                  DateTime.now().add(const Duration(days: 20)),
              inputType: InputType.date,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              validator: widget.validator,
              onChanged: widget.onChanged,
              enabled: widget.enabled,
            ),
          ),
        );
      },
    );
  }
}

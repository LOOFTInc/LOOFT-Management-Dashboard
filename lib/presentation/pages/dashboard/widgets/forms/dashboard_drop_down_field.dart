import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_form_field_container.dart';

import '../../../../../../../logic/cubits/theme/theme_cubit.dart';
import '../../../../widgets/custom_svg.dart';

class DashboardDropDownField extends StatefulWidget {
  /// Drop Down Form Field
  const DashboardDropDownField({
    super.key,
    required this.name,
    this.validator,
    this.onChanged,
    this.label,
    this.stringItems,
    this.initialValue,
    this.enabled = true,
    this.widgetItems,
    this.hint,
  });

  /// The Label of the text field
  final String? label;

  /// The name of the text field
  final String name;

  /// The items of the drop down field as strings
  final List<String>? stringItems;

  /// The items of the drop down field as DropdownMenuItems
  final List<DropdownMenuItem>? widgetItems;

  /// The validator of the text field
  final String? Function(dynamic)? validator;

  /// The onChanged of the text field
  final Function(dynamic)? onChanged;

  /// The initial value of the Drop Down
  final dynamic initialValue;

  /// Whether the field is enabled or not
  final bool enabled;

  /// The hint of the Drop down field
  final String? hint;

  @override
  State<DashboardDropDownField> createState() => _DashboardDropDownFieldState();
}

class _DashboardDropDownFieldState extends State<DashboardDropDownField> {
  /// The focus node of the text field
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    assert(widget.stringItems != null || widget.widgetItems != null);

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return DashboardFormFieldContainer(
          focusNode: _focusNode,
          label: widget.label,
          lessPadding: true,
          formField: FormBuilderDropdown<dynamic>(
            style: TextStyle(fontSize: 14, color: state.opacity100),
            initialValue: widget.initialValue,
            borderRadius: BorderRadius.circular(8),
            icon: const CustomSvg(
              svgPath: 'assets/icons/drop_down.svg',
            ),
            items: widget.widgetItems ??
                widget.stringItems!
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    )
                    .toList(),
            focusNode: _focusNode,
            focusColor: Colors.transparent,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: widget.name,
            dropdownColor: state.reverseOpacity100,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontSize: 14,
                color: state.opacity20,
              ),
            ),
            enabled: widget.enabled,
            validator: widget.validator,
            onChanged: widget.onChanged,
          ),
        );
      },
    );
  }
}

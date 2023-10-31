import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../../../logic/cubits/theme/theme_cubit.dart';
import 'dashboard_form_field_container.dart';

class DashboardTextFormField extends StatefulWidget {
  /// Text Form Field
  const DashboardTextFormField({
    super.key,
    required this.name,
    required this.hint,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.showPasswordToggle = false,
    this.label,
    this.enabled = true,
    this.initialValue,
  });

  /// The Label of the text field
  final String? label;

  /// The name of the text field
  final String name;

  /// The hint of the text field
  final String hint;

  /// The validator of the text field
  final String? Function(String?)? validator;

  /// The onChanged of the text field
  final Function(String?)? onChanged;

  /// Whether the text field is obscure
  final bool obscureText;

  /// Whether to show the password toggle
  final bool showPasswordToggle;

  /// Whether the text field is enabled
  final bool enabled;

  /// The initial value of the text field
  final String? initialValue;

  @override
  State<DashboardTextFormField> createState() => _DashboardTextFormFieldState();
}

class _DashboardTextFormFieldState extends State<DashboardTextFormField> {
  /// Whether the password is hidden
  late bool passwordHidden = widget.obscureText;

  /// The focus node of the text field
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return DashboardFormFieldContainer(
          focusNode: _focusNode,
          label: widget.label,
          formField: FormBuilderTextField(
            initialValue: widget.initialValue,
            enabled: widget.enabled,
            style: TextStyle(
              fontSize: 14,
              color: state.opacity100,
            ),
            focusNode: _focusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: widget.name,
            obscureText: passwordHidden,
            decoration: InputDecoration(
              suffixIcon: widget.showPasswordToggle
                  ? passwordHidden
                      ? IconButton(
                          icon: const Icon(Icons.visibility_outlined),
                          color: state.opacity20,
                          onPressed: () {
                            setState(() {
                              passwordHidden = !passwordHidden;
                            });
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.visibility_off_outlined),
                          color: state.opacity20,
                          onPressed: () {
                            setState(() {
                              passwordHidden = !passwordHidden;
                            });
                          },
                        )
                  : null,
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: state.opacity20,
              ),
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            validator: widget.validator,
            onChanged: widget.onChanged,
          ),
        );
      },
    );
  }
}

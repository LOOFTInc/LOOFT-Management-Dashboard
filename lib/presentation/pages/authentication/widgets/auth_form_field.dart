import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../../constants.dart';
import '../../../../../../logic/cubits/theme/theme_cubit.dart';

class AuthFormField extends StatefulWidget {
  /// A helper text field widget
  const AuthFormField({
    super.key,
    required this.name,
    required this.hint,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.showPasswordToggle = false,
  });

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

  @override
  State<AuthFormField> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  late bool passwordHidden = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return FormBuilderTextField(
          name: widget.name,
          obscureText: passwordHidden,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
            filled: true,
            fillColor: K.white5,
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: state.opacity20,
            ),
            errorMaxLines: 2,
            contentPadding: const EdgeInsets.all(16),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(color: state.opacity40),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(color: state.opacity10),
            ),
          ),
          validator: widget.validator,
          onChanged: widget.onChanged,
        );
      },
    );
  }
}

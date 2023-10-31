import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';

class CustomCheckBox extends StatelessWidget {
  /// Custom CheckBox
  const CustomCheckBox(
      {super.key, required this.value, required this.onChanged});

  /// Value of the checkbox
  final bool value;

  /// OnChanged callback
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Checkbox(
          value: value,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          activeColor: K.primaryBlue,
          side: BorderSide(
            width: 1.5,
            color: state.opacity20,
          ),
          onChanged: onChanged,
        );
      },
    );
  }
}

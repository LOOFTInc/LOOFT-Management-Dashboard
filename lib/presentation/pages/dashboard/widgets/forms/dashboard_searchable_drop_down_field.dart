import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

import '../../../../../../../logic/cubits/theme/theme_cubit.dart';
import '../../../../widgets/custom_svg.dart';
import 'dashboard_form_field_container.dart';

class DashboardSearchableDropDownField extends StatefulWidget {
  /// Searchable Drop Down Form Field
  const DashboardSearchableDropDownField({
    super.key,
    required this.name,
    this.validator,
    this.onChanged,
    this.label,
    required this.items,
    this.initialValue,
  });

  /// The Label of the text field
  final String? label;

  /// The name of the text field
  final String name;

  /// The items of the drop down field
  final List<String> items;

  /// The validator of the text field
  final String? Function(String?)? validator;

  /// The onChanged of the text field
  final Function(String?)? onChanged;

  /// The initial value of the Drop Down
  final String? initialValue;

  @override
  State<DashboardSearchableDropDownField> createState() =>
      _DashboardSearchableDropDownFieldState();
}

class _DashboardSearchableDropDownFieldState
    extends State<DashboardSearchableDropDownField> {
  /// The focus node of the text field
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return DashboardFormFieldContainer(
          focusNode: _focusNode,
          label: widget.label,
          lessPadding: true,
          formField: FormBuilderSearchableDropdown<String>(
            dropdownBuilder: (context, field) {
              return DropdownMenuItem<String>(
                value: field,
                child: Text(
                  field!,
                  style: const TextStyle(fontSize: 14),
                ),
              );
            },
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchDelay: const Duration(milliseconds: 0),
              menuProps: MenuProps(
                borderRadius: BorderRadius.circular(8),
                backgroundColor: state.reverseOpacity100,
              ),
              itemBuilder: (context, field, value) {
                return DropdownMenuItem<String>(
                  value: field,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      field,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  prefixIcon: const CustomSvg(
                    svgPath: 'assets/icons/search.svg',
                    size: 20,
                  ),
                  hintText: 'Search',
                  prefixIconConstraints: const BoxConstraints(
                    maxHeight: 30,
                    minWidth: 40,
                  ),
                  hintStyle: TextStyle(
                    color: state.opacity20,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6),
                    ),
                    borderSide: BorderSide(color: state.opacity40),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6),
                    ),
                    borderSide: BorderSide(color: state.opacity10),
                  ),
                ),
              ),
            ),
            initialValue: widget.initialValue ?? widget.items.first,
            items: widget.items,
            focusNode: _focusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: widget.name,
            dropdownButtonProps: const DropdownButtonProps(
              icon: CustomSvg(
                svgPath: 'assets/icons/drop_down.svg',
              ),
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
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

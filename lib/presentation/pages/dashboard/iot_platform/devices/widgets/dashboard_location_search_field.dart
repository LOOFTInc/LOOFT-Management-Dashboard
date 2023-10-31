import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:management_dashboard/data/repositories/firebase/places_api_repository.dart';
import 'package:management_dashboard/helper_functions.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/pages/dashboard/models/custom_place.dart';
import 'package:management_dashboard/presentation/pages/dashboard/widgets/forms/dashboard_form_field_container.dart';

class DashboardLocationSearchField extends StatefulWidget {
  /// Location Search Form Field
  const DashboardLocationSearchField({
    super.key,
    this.label,
    required this.name,
    required this.hint,
    this.enabled = true,
    this.initialValue,
    this.onLocationSelected,
    this.validator,
  });

  /// The Label of the text field
  final String? label;

  /// The name of the text field
  final String name;

  /// The hint of the text field
  final String hint;

  /// Whether the text field is enabled
  final bool enabled;

  /// The initial value of the text field
  final String? initialValue;

  /// Function to call when a new location is selected
  final void Function(CustomPlace)? onLocationSelected;

  /// Validator for the Location field
  final String? Function(CustomPlace?)? validator;

  @override
  State<DashboardLocationSearchField> createState() =>
      _DashboardLocationSearchFieldState();
}

class _DashboardLocationSearchFieldState
    extends State<DashboardLocationSearchField> {
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
          formField: FormBuilderTypeAhead<CustomPlace>(
            debounceDuration: const Duration(milliseconds: 100),
            initialValue: widget.initialValue == null
                ? null
                : CustomPlace(formattedAddress: widget.initialValue!),
            enabled: widget.enabled,
            focusNode: _focusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: widget.name,
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              color: state.reverseOpacity100,
              borderRadius: BorderRadius.circular(8),
            ),
            textFieldConfiguration: TextFieldConfiguration(
              style: TextStyle(fontSize: 14, color: state.opacity100),
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: state.opacity20,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
            itemBuilder: (BuildContext context, CustomPlace itemData) {
              return ListTile(
                title: Text(
                  itemData.formattedAddress,
                  style: const TextStyle(fontSize: 14),
                ),
              );
            },
            selectionToTextTransformer: (CustomPlace? selectedItem) =>
                selectedItem?.formattedAddress ?? '',
            suggestionsCallback: (String query) async {
              try {
                final response =
                    await PlacesAPIRepository.getAutoCompleteSuggestions(
                  query: query,
                );

                final List<CustomPlace> suggestions = [];
                for (final prediction in response.data) {
                  suggestions.add(
                    CustomPlace(
                      formattedAddress: prediction['description'],
                      placeID: prediction['place_id'],
                    ),
                  );
                }

                return suggestions;
              } catch (e) {
                HelperFunctions.printDebug(e);
                return [];
              }
            },
            onSuggestionSelected: widget.onLocationSelected,
            validator: widget.validator,
          ),
        );
      },
    );
  }
}

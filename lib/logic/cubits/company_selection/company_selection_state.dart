part of 'company_selection_cubit.dart';

/// State for [CompanySelectionCubit]
class CompanySelectionState {
  List<CompanyData> companies;

  CompanySelectionState({
    this.companies = const [],
  });
}

/// State for when the companies are loading
class CompaniesLoadingState extends CompanySelectionState {}

/// State for when the companies are loaded successfully
class CompaniesLoadingSuccessfulState extends CompanySelectionState {
  CompaniesLoadingSuccessfulState({required super.companies});
}

/// State for when the companies are not loaded successfully
class CompaniesErrorState extends CompanySelectionState {
  final String message;

  CompaniesErrorState({
    required this.message,
  });
}

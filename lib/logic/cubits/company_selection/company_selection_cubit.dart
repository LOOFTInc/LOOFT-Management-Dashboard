import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:management_dashboard/data/models/classes/company_data.dart';
import 'package:management_dashboard/data/repositories/firebase/companies_repository.dart';
import 'package:management_dashboard/helper_functions.dart';

part 'company_selection_state.dart';

/// Cubit for [CompanySelectionPage]
class CompanySelectionCubit extends Cubit<CompanySelectionState> {
  CompanySelectionCubit() : super(CompanySelectionState()) {
    loadCompanies();
  }

  final CompaniesRepository _companiesRepository = CompaniesRepository();

  /// Load the companies
  Future<void> loadCompanies() async {
    emit(CompaniesLoadingState());
    try {
      final result = await _companiesRepository.fetchCompanies()
          as QuerySnapshot<Map<String, dynamic>>;
      final List<CompanyData> companies = result.docs
          .map((e) => CompanyData.fromFirebaseJson(e.data(), e.id))
          .toList(growable: false);

      emit(CompaniesLoadingSuccessfulState(companies: companies));
    } catch (e) {
      emit(CompaniesErrorState(
          message: HelperFunctions.handleFireStoreError(e) ??
              'An error occurred loading Companies'));
    }
  }
}

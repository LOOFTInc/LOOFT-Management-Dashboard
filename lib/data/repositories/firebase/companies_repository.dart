import 'package:cloud_firestore/cloud_firestore.dart';

class CompaniesRepository {
  /// Firebase Firestore instance
  final FirebaseFirestore _firestore;

  CompaniesRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Fetches all the companies from the database
  Future fetchCompanies() async {
    return await _firestore.collection('Companies').get();
  }
}

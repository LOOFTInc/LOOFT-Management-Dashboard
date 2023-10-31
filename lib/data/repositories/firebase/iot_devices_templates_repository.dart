import 'package:cloud_firestore/cloud_firestore.dart';

class IoTDevicesTemplatesRepository {
  /// Company name for the current user
  final String companyName;

  /// Firebase Firestore instance
  final FirebaseFirestore _firestore;

  IoTDevicesTemplatesRepository(
      {FirebaseFirestore? firestore, required this.companyName})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Fetches all the IoT templates from Firebase
  Future fetchIoTTemplates() async {
    return await _firestore
        .collection('Companies/$companyName/IoT/others/templates')
        .get();
  }

  /// Adds a new IoT template
  Future addIoTTemplate({
    required Map<String, dynamic> data,
  }) async {
    return await _firestore
        .collection('Companies/$companyName/IoT/others/templates')
        .add(data)
        .then((value) => value.id);
  }

  /// Deletes an IoT template
  Future deleteIoTTemplate({
    required String templateID,
  }) async {
    return await _firestore
        .doc('Companies/$companyName/IoT/others/templates/$templateID')
        .delete();
  }

  /// Updates an IoT template
  Future updateIoTTemplate({
    required String templateID,
    required Map<String, dynamic> data,
  }) async {
    return await _firestore
        .doc('Companies/$companyName/IoT/others/templates/$templateID')
        .update(data)
        .then((value) => true);
  }

  /// Sets the default template
  Future setDefaultTemplate({
    required String? templateID,
  }) async {
    return await _firestore.doc('Companies/$companyName/IoT/others').update({
      'defaultTemplate': templateID,
    }).then((value) => true);
  }

  /// Fetches the default template
  Future fetchDefaultTemplate() async {
    return await _firestore
        .doc('Companies/$companyName/IoT/others')
        .get()
        .then((value) {
      return value.data()!['defaultTemplate'];
    });
  }
}

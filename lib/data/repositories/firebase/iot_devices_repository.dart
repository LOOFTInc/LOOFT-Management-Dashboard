import 'package:cloud_firestore/cloud_firestore.dart';

/// Firebase repository for devices
class IoTDevicesRepository {
  /// Company name for the current user
  final String companyName;

  /// Firebase Firestore instance
  final FirebaseFirestore _firestore;

  IoTDevicesRepository(
      {FirebaseFirestore? firestore, required this.companyName})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Gets a stream of Realtime data for IoT devices
  Stream<QuerySnapshot<Map<String, dynamic>>> getIoTRealtimeDataStream() {
    return _firestore
        .collection('Companies/$companyName/IoT/realtime_data/devices')
        .snapshots();
  }

  /// Gets a stream of Devices data for IoT devices
  Stream<QuerySnapshot<Map<String, dynamic>>> getIoTDevicesDataStream() {
    return _firestore
        .collection('Companies/$companyName/IoT/device_data/devices')
        .snapshots();
  }

  /// Fetches the historical data for an IoT device between two dates
  Future fetchIoTDevicesHistoricalDataBetweenDates({
    required String deviceID,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return await _firestore
        .collection('Companies/$companyName/IoT/historical_data/$deviceID')
        .where(
          'Time',
          isGreaterThanOrEqualTo: startDate,
          isLessThanOrEqualTo: endDate,
        )
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
  }

  /// Adds a new IoT device
  Future addOrUpdateIoTDevice({
    required String deviceID,
    required Map<String, dynamic> data,
  }) async {
    return await _firestore
        .doc('Companies/$companyName/IoT/device_data/devices/$deviceID')
        .set(
          data,
          SetOptions(merge: true),
        )
        .then((value) => true);
  }

  /// Deletes an IoT device
  Future deleteIoTDevice({
    required String deviceID,
  }) async {
    await _firestore
        .doc('Companies/$companyName/IoT/device_data/devices/$deviceID')
        .delete();
    await _firestore
        .doc('Companies/$companyName/IoT/realtime_data/devices/$deviceID')
        .delete();
  }

  /// Fetches the listeners for an IoT device
  Future fetchIoTDeviceListeners({
    required String deviceID,
  }) async {
    return await _firestore
        .collection(
            'Companies/$companyName/IoT/device_data/devices/$deviceID/listeners')
        .get();
  }

  /// Adds a new listener for an IoT device
  Future addIoTDeviceListener({
    required String deviceID,
    required Map<String, dynamic> data,
  }) async {
    return await _firestore
        .collection(
            'Companies/$companyName/IoT/device_data/devices/$deviceID/listeners')
        .add(data)
        .then((value) => value.id);
  }

  /// Deletes a listener for an IoT device
  Future deleteIoTDeviceListener({
    required String deviceID,
    required String listenerID,
  }) async {
    return await _firestore
        .doc(
            'Companies/$companyName/IoT/device_data/devices/$deviceID/listeners/$listenerID')
        .delete();
  }

  /// Updates a listener for an IoT device
  Future updateIoTDeviceListener({
    required String deviceID,
    required String listenerID,
    required Map<String, dynamic> data,
  }) async {
    return await _firestore
        .doc(
            'Companies/$companyName/IoT/device_data/devices/$deviceID/listeners/$listenerID')
        .update(data)
        .then((value) => true);
  }
}

import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// User Management Repository
class UserManagementRepository {
  /// Firebase Functions instance
  final FirebaseFunctions _firebaseFunctions;

  /// Firebase Storage instance
  final FirebaseStorage _firebaseStorage;

  /// Company name for the current user
  final String companyName;

  UserManagementRepository(
      {FirebaseFunctions? firebaseFunctions,
      FirebaseStorage? firebaseStorage,
      required this.companyName})
      : _firebaseFunctions = firebaseFunctions ?? FirebaseFunctions.instance,
        _firebaseStorage = firebaseStorage ??
            FirebaseStorage.instanceFor(bucket: 'gs://comfy-iot-v1_web');

  /// Fetch all Users
  Future<dynamic> fetchAllUsers() async {
    try {
      return await _firebaseFunctions.httpsCallable('getAllUsers').call({
        'company': companyName,
      }).then((value) => value.data);
    } catch (e) {
      return e;
    }
  }

  /// Create a User
  Future<dynamic> createUser({
    required String email,
    required String password,
    required String role,
    String? name,
    PlatformFile? image,
    String? phoneNumber,
  }) async {
    try {
      String? photoURL;
      if (image != null) {
        final result = await uploadFile(
          file: image,
          filePath:
              'user_images/${DateTime.now().millisecondsSinceEpoch}.${image.extension}',
        );

        if (result is String) {
          photoURL = result;
        } else {
          return result;
        }
      }

      return await _firebaseFunctions.httpsCallable('createUser').call({
        'company': companyName,
        'email': email,
        'password': password,
        'role': role,
        'name': name,
        'photoURL': photoURL,
        'phoneNumber': phoneNumber,
      }).then((value) => value.data);
    } catch (e) {
      return e;
    }
  }

  /// Update a User
  Future<dynamic> updateUser({
    required String uid,
    String? email,
    String? password,
    String? role,
    String? name,
    String? photoURL,
    PlatformFile? image,
    String? phoneNumber,
  }) async {
    if (photoURL != null && photoURL.isNotEmpty) {
      _firebaseStorage.refFromURL(photoURL).delete();
    }

    if (image != null) {
      final result = await uploadFile(
        file: image,
        filePath:
            'user_images/${DateTime.now().millisecondsSinceEpoch}.${image.extension}',
      );

      if (result is String) {
        photoURL = result;
      } else {
        return result;
      }
    }

    try {
      return await _firebaseFunctions.httpsCallable('updateUser').call({
        'company': companyName,
        'uid': uid,
        'email': email,
        'password': password,
        'role': role,
        'name': name,
        'photoURL': photoURL,
        'phoneNumber': phoneNumber,
      }).then((value) => value.data);
    } catch (e) {
      return e;
    }
  }

  /// Delete a User
  Future<dynamic> deleteUser({
    required String uid,
    String? photoURL,
  }) async {
    if (photoURL != null && photoURL.isNotEmpty) {
      _firebaseStorage.refFromURL(photoURL).delete();
    }

    try {
      return await _firebaseFunctions.httpsCallable('deleteUser').call({
        'company': companyName,
        'uid': uid,
      }).then((value) => value.data);
    } catch (e) {
      return e;
    }
  }

  /// Upload a file
  Future<dynamic> uploadFile({
    required PlatformFile file,
    required String filePath,
  }) async {
    try {
      return await _firebaseStorage.ref(filePath).putData(file.bytes!).then(
            (value) async => await value.ref.getDownloadURL(),
          );
    } catch (e) {
      return e;
    }
  }
}

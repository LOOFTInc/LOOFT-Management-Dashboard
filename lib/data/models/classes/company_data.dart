/// Company data class
class CompanyData {
  /// Company name
  String name;

  /// Company image URL
  String? imageURL;

  CompanyData({
    required this.name,
    this.imageURL,
  });

  /// Converts a map to [CompanyData]
  factory CompanyData.fromMap(Map<String, dynamic> map) {
    return CompanyData(
      name: map['name'],
      imageURL: map['imageURL'],
    );
  }

  /// Converts [CompanyData] to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageURL': imageURL,
    };
  }

  /// Converts Firebase JSON to [CompanyData]
  factory CompanyData.fromFirebaseJson(
      Map<String, dynamic> json, String documentID) {
    return CompanyData(
      name: documentID,
      imageURL: json['imageURL'],
    );
  }
}

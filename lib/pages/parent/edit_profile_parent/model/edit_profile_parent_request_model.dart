class EditProfileParentRequestModel {
  final String? email;
  final String? phone;
  final String? name;
  final String? nationalNumber;

  EditProfileParentRequestModel({
    this.email,
    this.nationalNumber,
    this.name,
    this.phone,
  });

  /// Convert JSON (from API or Postman) → Dart object
  factory EditProfileParentRequestModel.fromJson(Map<String, dynamic> json) {
    return EditProfileParentRequestModel(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      nationalNumber: json['national_number'] ?? '',
    );
  }

  /// Convert Dart object → JSON (for API request body)
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'national_number': nationalNumber,
      'phone': phone,
      'name': name,
    };
  }
}
// Model classes for EditProfile flow

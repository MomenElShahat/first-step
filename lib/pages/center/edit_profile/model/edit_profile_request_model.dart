class EditProfileRequestModel {
  final String? email;
  final String? address;
  final String? location;
  final String? nurseryName;
  final String? phone;
  final int? cityId;
  final String? neighborhood;
  final String? name;

  EditProfileRequestModel({
    this.email,
    this.address,
    this.location,
    this.nurseryName,
    this.phone,
    this.name,
    this.cityId,
    this.neighborhood,
  });

  /// Convert JSON (from API or Postman) → Dart object
  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) {
    return EditProfileRequestModel(
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      location: json['location'] ?? '',
      nurseryName: json['nursery_name'] ?? '',
      phone: json['phone'] ?? '',
      name: json['name'] ?? '',
      cityId: json['city_id'] ?? 0,
      neighborhood: json['neighborhood'] ?? '',
    );
  }

  /// Convert Dart object → JSON (for API request body)
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'address': address,
      'location': location,
      'name': name,
      'nursery_name': nurseryName,
      'phone': phone,
      'city_id': cityId,
      'neighborhood': neighborhood,
    };
  }
}
// Model classes for EditProfile flow

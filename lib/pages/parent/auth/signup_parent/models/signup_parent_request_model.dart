import 'dart:convert';

class SignupParentRequestModel {
  final String email;
  final String password;
  final String name;
  final String address;
  final String nationalNumber;
  final String phone;
  final List<ChildModel> children;

  SignupParentRequestModel({
    required this.email,
    required this.password,
    required this.name,
    required this.address,
    required this.nationalNumber,
    required this.phone,
    required this.children,
  });

  factory SignupParentRequestModel.fromJson(json) {
    return SignupParentRequestModel(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      address: json['address'],
      nationalNumber: json['national_number'],
      phone: json['phone'],
      children: (json['children'] as List)
          .map((child) => ChildModel.fromJson(child))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'address': address,
        'national_number': nationalNumber,
        'phone': phone,
        'children': children.map((e) => e.toJson()).toList(),
      };
}

class ChildModel {
  final String kinship;
  final String childName;
  final String birthdayDate;
  final String gender;
  final bool disease;
  List<DiseaseDetailModel>? diseaseDetails;
  final bool allergy;
  final String parentName;
  final String motherName;
  String? recommendations;
  String? description3Words;
  String? thingsChildLikes;
  String? notes;
  final List<AuthorizedPersonModel> authorizedPersons;
  List<AllergyModel>? allergies;

  ChildModel({
    required this.kinship,
    required this.childName,
    required this.birthdayDate,
    required this.gender,
    required this.disease,
    this.diseaseDetails,
    required this.allergy,
    required this.parentName,
    required this.motherName,
    this.recommendations,
    this.description3Words,
    this.thingsChildLikes,
    this.notes,
    required this.authorizedPersons,
    this.allergies,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      kinship: json['kinship'],
      childName: json['child_name'],
      birthdayDate: json['birthday_date'],
      gender: json['gender'],
      disease: json['disease'],
      diseaseDetails: (json['disease_details'] as List)
          .map((e) => DiseaseDetailModel.fromJson(e))
          .toList(),
      allergy: json['allergy'],
      parentName: json['parent_name'],
      motherName: json['mother_name'],
      recommendations: json['recommendations'],
      description3Words: json['description_3_words'],
      thingsChildLikes: json['things_child_likes'],
      notes: json['notes'],
      authorizedPersons: (json['authorized_persons'] as List)
          .map((e) => AuthorizedPersonModel.fromJson(e))
          .toList(),
      allergies: (json['allergies'] as List)
          .map((e) => AllergyModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kinship': kinship,
      'child_name': childName,
      'birthday_date': birthdayDate,
      'gender': gender,
      'disease': disease,
      'disease_details': diseaseDetails?.map((e) => e.toJson()).toList(),
      'allergy': allergy,
      'parent_name': parentName,
      'mother_name': motherName,
      'recommendations': recommendations,
      'description_3_words': description3Words,
      'things_child_likes': thingsChildLikes,
      'notes': notes,
      'authorized_persons': authorizedPersons.map((e) => e.toJson()).toList(),
      'allergies': allergies?.map((e) => e.toJson()).toList(),
    };
  }
}

class DiseaseDetailModel {
  String? diseaseName;
  String? medicament;
  String? emergency;

  DiseaseDetailModel({
    this.diseaseName,
    this.medicament,
    this.emergency,
  });

  factory DiseaseDetailModel.fromJson(Map<String, dynamic> json) {
    return DiseaseDetailModel(
      diseaseName: json['disease_name'],
      medicament: json['medicament'],
      emergency: json['emergency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disease_name': diseaseName,
      'medicament': medicament,
      'emergency': emergency,
    };
  }
}

class AuthorizedPersonModel {
  int? id;
  String? name;
  String? cin;

  AuthorizedPersonModel({
    this.id,
    this.name,
    this.cin,
  });

  factory AuthorizedPersonModel.fromJson(Map<String, dynamic> json) {
    return AuthorizedPersonModel(
      id: json["id"],
      name: json['name'],
      cin: json['cin'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cin': cin,
      };
}

class AllergyModel {
  int? id;
  String? name;
  String? allergyCauses;
  String? allergyEmergency;

  AllergyModel({
    this.id,
    this.name,
    this.allergyCauses,
    this.allergyEmergency,
  });

  factory AllergyModel.fromJson(Map<String, dynamic> json) {
    return AllergyModel(
      id: json['id'],
      name: json['name'],
      allergyCauses: json['allergy_causes'],
      allergyEmergency: json['allergy_emergency'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'allergy_causes': allergyCauses,
        'allergy_emergency': allergyEmergency,
      };

  /// Handles both List<String> or String JSON formats safely
  static List<String>? _parseAllergyCauses(dynamic value) {
    if (value == null) return null;

    try {
      if (value is List) {
        return value.map((e) => e.toString()).toList();
      } else if (value is String) {
        dynamic decoded = value;

        // Keep decoding until we reach the real List<String>
        while (decoded is String) {
          decoded = jsonDecode(decoded);
        }

        if (decoded is List) {
          return decoded.map((e) => e.toString()).toList();
        }
      }
    } catch (e) {
      print("Error parsing allergyCauses: $e");
    }

    return null;
  }
}

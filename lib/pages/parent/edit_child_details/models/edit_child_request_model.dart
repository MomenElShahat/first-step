import '../../auth/signup_parent/models/signup_parent_request_model.dart';

class EditChildRequestModel {
  String? childName;
  String? birthdayDate;
  String? gender;
  bool? disease;
  String? diseaseName;
  String? medicamentDisease;
  bool? allergy;
  String? parentName;
  String? motherName;
  String? recommendations;
  List<AuthorizedPersonModel>? authorizedPeople;
  List<AllergyModel>? allergies;

  EditChildRequestModel({
    this.childName,
    this.birthdayDate,
    this.gender,
    this.disease,
    this.diseaseName,
    this.medicamentDisease,
    this.allergy,
    this.parentName,
    this.motherName,
    this.recommendations,
    this.authorizedPeople,
    this.allergies,
  });

  factory EditChildRequestModel.fromJson(Map<String, dynamic> json) {
    return EditChildRequestModel(
      childName: json['child_name'],
      birthdayDate: json['birthday_date'],
      gender: json['gender'],
      disease: json['disease'],
      diseaseName: json['disease_name'],
      medicamentDisease: json['medicament_disease'],
      allergy: json['allergy'],
      parentName: json['parent_name'],
      motherName: json['mother_name'],
      recommendations: json['recommendations'],
      authorizedPeople: (json['authorized_people'] as List)
          .map((e) => AuthorizedPersonModel.fromJson(e))
          .toList(),
      allergies: (json['allergies'] as List)
          .map((e) => AllergyModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'child_name': childName,
      'birthday_date': birthdayDate,
      'gender': gender,
      'disease': disease,
      'disease_name': diseaseName,
      'medicament_disease': medicamentDisease,
      'allergy': allergy,
      'parent_name': parentName,
      'mother_name': motherName,
      'recommendations': recommendations,
      'authorized_people': authorizedPeople?.map((e) => e.toJson()).toList() ?? [],
      'allergies': allergies?.map((e) => e.toJson()).toList() ?? [],
    };
  }
}

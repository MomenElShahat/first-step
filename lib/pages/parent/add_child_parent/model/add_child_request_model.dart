import '../../auth/signup_parent/models/signup_parent_request_model.dart';

class AddChildRequestModel {
  final String childName;
  final String birthdayDate;
  final String gender;
  final bool? disease;
  final List<DiseaseDetailModel> diseaseDetails;
  final bool? allergy;
  final String parentName;
  final String motherName;
  final String recommendations;
  final String description3Words;
  final String thingsChildLikes;
  final String notes;
  final List<AuthorizedPersonModel> authorizedPeople;
  final List<AllergyModel> allergies;

  AddChildRequestModel({
    required this.childName,
    required this.birthdayDate,
    required this.gender,
    this.disease,
    required this.diseaseDetails,
    this.allergy,
    required this.parentName,
    required this.motherName,
    required this.recommendations,
    required this.description3Words,
    required this.thingsChildLikes,
    required this.notes,
    required this.authorizedPeople,
    required this.allergies,
  });

  Map<String, dynamic> toJson() => {
        "child_name": childName,
        "birthday_date": birthdayDate,
        "gender": gender,
        "disease": disease,
        "disease_details": diseaseDetails.map((e) => e.toJson()).toList(),
        "allergy": allergy,
        "parent_name": parentName,
        "mother_name": motherName,
        "recommendations": recommendations,
        "description_3_words": description3Words,
        "things_child_likes": thingsChildLikes,
        "notes": notes,
        "authorized_people": authorizedPeople.map((e) => e.toJson()).toList(),
        "allergies": allergies.map((e) => e.toJson()).toList(),
      };
}

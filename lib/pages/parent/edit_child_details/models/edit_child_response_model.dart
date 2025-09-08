class EditChildResponseModel {
  String? message;
  Child? child;

  EditChildResponseModel({this.message, this.child});

  EditChildResponseModel.fromJson(json) {
    message = json['message'];
    child = json['child'] != null ? new Child.fromJson(json['child']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.child != null) {
      data['child'] = this.child!.toJson();
    }
    return data;
  }
}

class Child {
  int? id;
  int? userId;
  String? childName;
  String? birthdayDate;
  String? gender;
  String? disease;
  String? diseaseName;
  String? medicamentDisease;
  String? allergy;
  String? parentName;
  String? motherName;
  String? recommendations;
  String? createdAt;
  String? updatedAt;
  int? centerId;
  String? description3Words;
  String? thingsChildLikes;
  String? notes;
  String? kinship;
  int? centerBranchId;

  Child(
      {this.id,
        this.userId,
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
        this.createdAt,
        this.updatedAt,
        this.centerId,
        this.description3Words,
        this.thingsChildLikes,
        this.notes,
        this.kinship,
        this.centerBranchId});

  Child.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    childName = json['child_name'];
    birthdayDate = json['birthday_date'];
    gender = json['gender'];
    disease = json['disease'];
    diseaseName = json['disease_name'];
    medicamentDisease = json['medicament_disease'];
    allergy = json['allergy'];
    parentName = json['parent_name'];
    motherName = json['mother_name'];
    recommendations = json['recommendations'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    centerId = json['center_id'];
    description3Words = json['description_3_words'];
    thingsChildLikes = json['things_child_likes'];
    notes = json['notes'];
    kinship = json['Kinship'];
    centerBranchId = json['center_branch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['child_name'] = this.childName;
    data['birthday_date'] = this.birthdayDate;
    data['gender'] = this.gender;
    data['disease'] = this.disease;
    data['disease_name'] = this.diseaseName;
    data['medicament_disease'] = this.medicamentDisease;
    data['allergy'] = this.allergy;
    data['parent_name'] = this.parentName;
    data['mother_name'] = this.motherName;
    data['recommendations'] = this.recommendations;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['center_id'] = this.centerId;
    data['description_3_words'] = this.description3Words;
    data['things_child_likes'] = this.thingsChildLikes;
    data['notes'] = this.notes;
    data['Kinship'] = this.kinship;
    data['center_branch_id'] = this.centerBranchId;
    return data;
  }
}

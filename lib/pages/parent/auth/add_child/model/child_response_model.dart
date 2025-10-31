class ChildResponseModel {
  String? message;
  List<Data>? data;

  ChildResponseModel({this.message, this.data});

  ChildResponseModel.fromJson(json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? childName;
  int? centerId;
  Null? centerName;
  int? branchId;
  Null? branchName;
  String? birthdayDate;
  String? gender;
  Null? disease;
  Null? diseaseDetails;
  Null? allergy;
  String? parentName;
  String? motherName;
  Null? recommendations;
  Null? notes;
  Null? kinship;
  String? image;
  Null? thingsChildLikes;
  Null? description3Words;

  Data(
      {this.id,
        this.childName,
        this.centerId,
        this.centerName,
        this.branchId,
        this.branchName,
        this.birthdayDate,
        this.gender,
        this.disease,
        this.diseaseDetails,
        this.allergy,
        this.parentName,
        this.motherName,
        this.recommendations,
        this.notes,
        this.kinship,
        this.image,
        this.thingsChildLikes,
        this.description3Words});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    childName = json['child_name'];
    centerId = json['center_id'];
    centerName = json['center_name'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    birthdayDate = json['birthday_date'];
    gender = json['gender'];
    disease = json['disease'];
    diseaseDetails = json['disease_details'];
    allergy = json['allergy'];
    parentName = json['parent_name'];
    motherName = json['mother_name'];
    recommendations = json['recommendations'];
    notes = json['notes'];
    kinship = json['kinship'];
    image = json['image'];
    thingsChildLikes = json['things_child_likes'];
    description3Words = json['description_3_words'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['child_name'] = this.childName;
    data['center_id'] = this.centerId;
    data['center_name'] = this.centerName;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['birthday_date'] = this.birthdayDate;
    data['gender'] = this.gender;
    data['disease'] = this.disease;
    data['disease_details'] = this.diseaseDetails;
    data['allergy'] = this.allergy;
    data['parent_name'] = this.parentName;
    data['mother_name'] = this.motherName;
    data['recommendations'] = this.recommendations;
    data['notes'] = this.notes;
    data['kinship'] = this.kinship;
    data['image'] = this.image;
    data['things_child_likes'] = this.thingsChildLikes;
    data['description_3_words'] = this.description3Words;
    return data;
  }
}

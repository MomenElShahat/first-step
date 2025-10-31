class AddParentsResponseModel {
  bool? success;
  List<Data>? data;
  String? message;
  int? status;

  AddParentsResponseModel({this.success, this.data, this.message, this.status});

  AddParentsResponseModel.fromJson(json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? nationalNumber;
  String? role;
  List<Children>? children;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.nationalNumber,
        this.role,
        this.children});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    nationalNumber = json['national_number'];
    role = json['role'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['national_number'] = this.nationalNumber;
    data['role'] = this.role;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int? id;
  String? childName;
  int? centerId;
  String? centerName;
  int? branchId;
  String? branchName;
  String? birthdayDate;
  String? gender;
  int? disease;
  Null? diseaseDetails;
  int? allergy;
  String? parentName;
  String? motherName;
  String? recommendations;
  String? notes;
  String? kinship;
  String? image;
  String? thingsChildLikes;
  String? description3Words;

  Children(
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

  Children.fromJson(Map<String, dynamic> json) {
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

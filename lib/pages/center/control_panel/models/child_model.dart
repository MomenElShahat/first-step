import 'dart:convert';

import 'package:first_step/pages/parent/auth/signup_parent/models/signup_parent_request_model.dart';

class ChildModel {
  User? user;
  int? id;
  String? childName;
  int? centerId;
  String? centerName;
  int? branchId;
  String? branchName;
  String? birthdayDate;
  String? gender;
  int? disease;
  String? diseaseName;
  List<DiseaseDetailModel>? diseaseDetails;
  String? medicamentDisease;
  int? allergy;
  String? parentName;
  String? motherName;
  String? recommendations;
  String? notes;
  String? kinship;
  String? thingsChildLikes;
  String? description3Words;
  List<AuthorizedPersonModel>? authorizedPeople;
  List<AllergyModel>? allergies;
  List<Enrollments>? enrollments;
  int reportsCount = 0;

  ChildModel(
      {this.user,
        this.id,
        this.childName,
        this.centerId,
        this.centerName,
        this.branchId,
        this.branchName,
        this.birthdayDate,
        this.gender,
        this.disease,
        this.diseaseName,
        this.medicamentDisease,
        this.allergy,
        this.parentName,
        this.motherName,
        this.recommendations,
        this.diseaseDetails,
        this.notes,
        this.kinship,
        this.thingsChildLikes,
        this.description3Words,
        this.authorizedPeople,
        this.allergies,
        this.enrollments});

  ChildModel.fromJson(json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    id = json['id'];
    childName = json['child_name'];
    centerId = json['center_id'];
    centerName = json['center_name'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    birthdayDate = json['birthday_date'];
    gender = json['gender'];
    disease = json['disease'];
    diseaseName = json['disease_name'];
    medicamentDisease = json['medicament_disease'];
    allergy = json['allergy'];
    parentName = json['parent_name'];
    motherName = json['mother_name'];
    recommendations = json['recommendations'];
    notes = json['notes'];
    kinship = json['Kinship'];
    thingsChildLikes = json['things_child_likes'];
    description3Words = json['description_3_words'];
    if (json['disease_details'] != null) {
      diseaseDetails = <DiseaseDetailModel>[];
      dynamic raw = json['disease_details'];

      // تأكد أنه String، ثم decode
      if (raw is String) {
        raw = jsonDecode(raw);
      }

      if (raw is List) {
        raw.forEach((v) {
          diseaseDetails!.add(DiseaseDetailModel.fromJson(v));
        });
      }
    }
    if (json['authorized_people'] != null) {
      authorizedPeople = <AuthorizedPersonModel>[];
      json['authorized_people'].forEach((v) {
        authorizedPeople!.add(new AuthorizedPersonModel.fromJson(v));
      });
    }
    if (json['allergies'] != null) {
      allergies = <AllergyModel>[];
      json['allergies'].forEach((v) {
        allergies!.add(new AllergyModel.fromJson(v));
      });
    }
    if (json['enrollments'] != null) {
      enrollments = <Enrollments>[];
      json['enrollments'].forEach((v) {
        enrollments!.add(new Enrollments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['id'] = this.id;
    data['child_name'] = this.childName;
    data['center_id'] = this.centerId;
    data['center_name'] = this.centerName;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['birthday_date'] = this.birthdayDate;
    data['gender'] = this.gender;
    data['disease'] = this.disease;
    data['disease_name'] = this.diseaseName;
    data['medicament_disease'] = this.medicamentDisease;
    data['allergy'] = this.allergy;
    data['parent_name'] = this.parentName;
    data['mother_name'] = this.motherName;
    data['recommendations'] = this.recommendations;
    data['notes'] = this.notes;
    data['Kinship'] = this.kinship;
    data['things_child_likes'] = this.thingsChildLikes;
    data['description_3_words'] = this.description3Words;
    if (this.diseaseDetails != null) {
      data['disease_details'] =
          this.diseaseDetails!.map((v) => v.toJson()).toList();
    }
    if (this.authorizedPeople != null) {
      data['authorized_people'] =
          this.authorizedPeople!.map((v) => v.toJson()).toList();
    }
    if (this.allergies != null) {
      data['allergies'] = this.allergies!.map((v) => v.toJson()).toList();
    }
    if (this.enrollments != null) {
      data['enrollments'] = this.enrollments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? phone;
  String? address;

  User({this.name, this.email, this.phone, this.address});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}

class Enrollments {
  int? id;
  int? branchId;
  String? branchName;
  int? centerId;
  int? userId;
  String? parentPhone;
  String? parentName;
  String? priceAmount;
  String? enrollmentType;
  String? responseSpeed;
  String? enrollmentDate;
  String? status;

  Enrollments(
      {this.id,
        this.branchId,
        this.branchName,
        this.centerId,
        this.userId,
        this.parentPhone,
        this.parentName,
        this.priceAmount,
        this.enrollmentType,
        this.responseSpeed,
        this.enrollmentDate,
        this.status});

  Enrollments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    centerId = json['center_id'];
    userId = json['user_id'];
    parentPhone = json['parent_phone'];
    parentName = json['parent_name'];
    priceAmount = json['price_amount'];
    enrollmentType = json['enrollment_type'];
    responseSpeed = json['response_speed'];
    enrollmentDate = json['enrollment_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['center_id'] = this.centerId;
    data['user_id'] = this.userId;
    data['parent_phone'] = this.parentPhone;
    data['parent_name'] = this.parentName;
    data['price_amount'] = this.priceAmount;
    data['enrollment_type'] = this.enrollmentType;
    data['response_speed'] = this.responseSpeed;
    data['enrollment_date'] = this.enrollmentDate;
    data['status'] = this.status;
    return data;
  }
}

class DiseaseDetails {
  String? diseaseName;
  String? medicament;
  String? emergency;

  DiseaseDetails({this.diseaseName, this.medicament, this.emergency});

  DiseaseDetails.fromJson(Map<String, dynamic> json) {
    diseaseName = json['disease_name'];
    medicament = json['medicament'];
    emergency = json['emergency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disease_name'] = this.diseaseName;
    data['medicament'] = this.medicament;
    data['emergency'] = this.emergency;
    return data;
  }
}


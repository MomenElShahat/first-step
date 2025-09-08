import 'package:get/get.dart';

class CenterEnrollmentsModel {
  List<CenterEnrollment>? data;

  CenterEnrollmentsModel({this.data});

  CenterEnrollmentsModel.fromJson(json) {
    if (json['data'] != null) {
      data = <CenterEnrollment>[];
      json['data'].forEach((v) {
        data!.add(new CenterEnrollment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CenterEnrollment {
  int? enrollmentId;
  String? status;
  String? enrollmentType;
  String? priceAmount;
  String? enrollmentDate;
  String? branchName;
  int? branchId;
  int? branchPriceId;
  String? startingTime;
  String? endingTime;
  String? startingDate;
  String? endingDate;
  String? day;
  String? dayString;
  List<Children>? children;
  RxBool isResponding = false.obs;
  RxBool isRespondingReject = false.obs;

  CenterEnrollment(
      {this.enrollmentId,
        this.status,
        this.enrollmentType,
        this.priceAmount,
        this.enrollmentDate,
        this.branchName,
        this.branchId,
        this.branchPriceId,
        this.startingTime,
        this.endingTime,
        this.startingDate,
        this.endingDate,
        this.day,
        this.dayString,
        this.children});

  CenterEnrollment.fromJson(Map<String, dynamic> json) {
    enrollmentId = json['enrollment_id'];
    status = json['status'];
    enrollmentType = json['enrollment_type'];
    priceAmount = json['price_amount'];
    enrollmentDate = json['enrollment_date'];
    branchName = json['branch_name'];
    branchId = json['branch_id'];
    branchPriceId = json['branch_price_id'];
    startingTime = json['starting_time'];
    endingTime = json['ending_time'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    day = json['day'];
    dayString = json['day_string'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enrollment_id'] = this.enrollmentId;
    data['status'] = this.status;
    data['enrollment_type'] = this.enrollmentType;
    data['price_amount'] = this.priceAmount;
    data['enrollment_date'] = this.enrollmentDate;
    data['branch_name'] = this.branchName;
    data['branch_id'] = this.branchId;
    data['branch_price_id'] = this.branchPriceId;
    data['starting_time'] = this.startingTime;
    data['ending_time'] = this.endingTime;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    data['day'] = this.day;
    data['day_string'] = this.dayString;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int? childId;
  String? childName;
  String? gender;

  Children({this.childId, this.childName, this.gender});

  Children.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    childName = json['child_name'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['child_name'] = this.childName;
    data['gender'] = this.gender;
    return data;
  }
}

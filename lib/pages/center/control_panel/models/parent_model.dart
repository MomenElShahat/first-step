import 'package:first_step/pages/center/control_panel/models/child_model.dart';
import 'package:get/get.dart';

class ParentModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? emailVerifiedAt;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? nationalNumber;
  int? branchId;
  List<ChildModel>? children;
  List<Enrollments>? enrollments;

  ParentModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.emailVerifiedAt,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.nationalNumber,
      this.branchId,
      this.children,
      this.enrollments});

  ParentModel.fromJson(json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nationalNumber = json['national_number'];
    branchId = json['branch_id'];
    if (json['children'] != null) {
      children = <ChildModel>[];
      json['children'].forEach((v) {
        children!.add(new ChildModel.fromJson(v));
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
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['national_number'] = this.nationalNumber;
    data['branch_id'] = this.branchId;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    if (this.enrollments != null) {
      data['enrollments'] = this.enrollments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Enrollments {
  int? id;
  int? centerId;
  int? userId;
  int? centerBranchId;
  String? reservationNumber;
  String? parentPhone;
  String? priceAmount;
  String? enrollmentType;
  String? hoursPerDay;
  String? responseSpeed;
  String? enrollmentDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? day;
  String? startingTime;
  String? endingTime;
  String? startingDate;
  String? endingDate;
  RxBool isResponding = false.obs;
  RxBool isRespondingReject = false.obs;

  Enrollments(
      {this.id,
      this.centerId,
      this.userId,
      this.centerBranchId,
      this.reservationNumber,
      this.parentPhone,
      this.priceAmount,
      this.enrollmentType,
      this.hoursPerDay,
      this.responseSpeed,
      this.enrollmentDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.day,
      this.startingTime,
      this.endingTime,
      this.startingDate,
      this.endingDate});

  Enrollments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    centerId = json['center_id'];
    userId = json['user_id'];
    centerBranchId = json['center_branch_id'];
    reservationNumber = json['reservation_number'];
    parentPhone = json['parent_phone'];
    priceAmount = json['price_amount'];
    enrollmentType = json['enrollment_type'];
    hoursPerDay = json['hours_per_day'];
    responseSpeed = json['response_speed'];
    enrollmentDate = json['enrollment_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    day = json['day'];
    startingTime = json['starting_time'];
    endingTime = json['ending_time'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['center_id'] = this.centerId;
    data['user_id'] = this.userId;
    data['center_branch_id'] = this.centerBranchId;
    data['reservation_number'] = this.reservationNumber;
    data['parent_phone'] = this.parentPhone;
    data['price_amount'] = this.priceAmount;
    data['enrollment_type'] = this.enrollmentType;
    data['hours_per_day'] = this.hoursPerDay;
    data['response_speed'] = this.responseSpeed;
    data['enrollment_date'] = this.enrollmentDate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['day'] = this.day;
    data['starting_time'] = this.startingTime;
    data['ending_time'] = this.endingTime;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    return data;
  }
}

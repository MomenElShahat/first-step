import 'package:get/get.dart';

class ParentNotificationsModel {
  String? id;
  String? notifiableType;
  int? notifiableId;
  int? reportId;
  String? title;
  String? description;
  String? date;
  String? time;
  String? notificationType;
  String? enrollmentId;
  String? readAt;
  String? createdAt;
  String? updatedAt;
  Report? report;
  Enrollment? enrollment;
  String? type;

  ParentNotificationsModel(
      {this.id,
      this.notifiableType,
      this.notifiableId,
      this.reportId,
      this.title,
      this.description,
      this.date,
      this.time,
      this.notificationType,
      this.enrollmentId,
      this.readAt,
      this.createdAt,
      this.updatedAt,
      this.enrollment,
      this.report,
      this.type});

  ParentNotificationsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    reportId = json['report_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
    notificationType = json['notification_type'];
    enrollmentId = json['enrollment_id'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    enrollment = json['enrollment'] != null ? new Enrollment.fromJson(json['enrollment']) : null;
    report = json['report'] != null ? new Report.fromJson(json['report']) : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['notifiable_type'] = this.notifiableType;
    data['notifiable_id'] = this.notifiableId;
    data['report_id'] = this.reportId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    data['time'] = this.time;
    data['notification_type'] = this.notificationType;
    data['enrollment_id'] = this.enrollmentId;
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.enrollment != null) {
      data['enrollment'] = this.enrollment!.toJson();
    }
    if (this.report != null) {
      data['report'] = this.report!.toJson();
    }
    data['type'] = this.type;
    return data;
  }
}

class Report {
  int? id;
  int? childId;
  String? activities;
  String? meals;
  String? napTime;
  String? behavior;
  String? notes;
  String? createdAt;
  String? updatedAt;

  Report({this.id, this.childId, this.activities, this.meals, this.napTime, this.behavior, this.notes, this.createdAt, this.updatedAt});

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    childId = json['child_id'];
    activities = json['activities'];
    meals = json['meals'];
    napTime = json['nap_time'];
    behavior = json['behavior'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['child_id'] = this.childId;
    data['activities'] = this.activities;
    data['meals'] = this.meals;
    data['nap_time'] = this.napTime;
    data['behavior'] = this.behavior;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Enrollment {
  int? userId;
  int? centerId;
  int? centerBranchId;
  int? branchPriceId;
  String? reservationNumber;
  String? status;
  String? enrollmentDate;
  String? enrollmentType;
  String? parentPhone;
  String? priceAmount;
  String? startingDate;
  String? endingDate;
  String? startingTime;
  String? endingTime;
  String? month;
  String? dayString;
  String? updatedAt;
  String? createdAt;
  String? centerBranchName;
  int? id;
  RxBool isResponding = false.obs;
  RxBool isRespondingReject = false.obs;

  Enrollment(
      {this.userId,
      this.centerId,
      this.centerBranchId,
      this.branchPriceId,
      this.reservationNumber,
      this.centerBranchName,
      this.status,
      this.enrollmentDate,
      this.enrollmentType,
      this.parentPhone,
      this.priceAmount,
      this.startingDate,
      this.endingDate,
      this.startingTime,
      this.endingTime,
      this.month,
      this.dayString,
      this.updatedAt,
      this.createdAt,
      this.id});

  Enrollment.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    centerId = json['center_id'];
    centerBranchId = json['center_branch_id'];
    branchPriceId = json['branch_price_id'];
    reservationNumber = json['reservation_number'];
    status = json['status'];
    enrollmentDate = json['enrollment_date'];
    enrollmentType = json['enrollment_type'];
    parentPhone = json['parent_phone'];
    priceAmount = json['price_amount'].toString();
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    startingTime = json['starting_time'];
    endingTime = json['ending_time'];
    month = json['month'];
    dayString = json['day_string'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    centerBranchName = json['center_branch_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['center_branch_name'] = this.centerBranchName;
    data['center_id'] = this.centerId;
    data['center_branch_id'] = this.centerBranchId;
    data['branch_price_id'] = this.branchPriceId;
    data['reservation_number'] = this.reservationNumber;
    data['status'] = this.status;
    data['enrollment_date'] = this.enrollmentDate;
    data['enrollment_type'] = this.enrollmentType;
    data['parent_phone'] = this.parentPhone;
    data['price_amount'] = this.priceAmount;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    data['starting_time'] = this.startingTime;
    data['ending_time'] = this.endingTime;
    data['month'] = this.month;
    data['day_string'] = this.dayString;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

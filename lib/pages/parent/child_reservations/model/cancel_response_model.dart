class CancelResponseModel {
  String? message;
  Enrollment? enrollment;

  CancelResponseModel({this.message, this.enrollment});

  CancelResponseModel.fromJson(json) {
    message = json['message'];
    enrollment = json['enrollment'] != null
        ? new Enrollment.fromJson(json['enrollment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.enrollment != null) {
      data['enrollment'] = this.enrollment!.toJson();
    }
    return data;
  }
}

class Enrollment {
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
  List<String>? day;
  String? startingTime;
  String? endingTime;
  String? startingDate;
  String? endingDate;

  Enrollment(
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

  Enrollment.fromJson(Map<String, dynamic> json) {
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

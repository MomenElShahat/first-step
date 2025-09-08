class EnrollmentDetailsModel {
  EnrollmentData? data;

  EnrollmentDetailsModel({this.data});

  EnrollmentDetailsModel.fromJson(json) {
    data = json['data'] != null ? new EnrollmentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EnrollmentData {
  int? id;
  int? branchId;
  String? branchName;
  int? centerId;
  int? branchPriceId;
  String? centerName;
  int? userId;
  String? parentPhone;
  String? parentName;
  String? priceAmount;
  String? enrollmentType;
  String? responseSpeed;
  String? enrollmentDate;
  String? status;
  String? startingTime;
  String? endingTime;
  String? startingDate;
  String? endingDate;
  String? day;
  String? dayString;
  int? childrenCount;
  List<Children>? children;

  EnrollmentData(
      {this.id,
        this.branchId,
        this.branchName,
        this.centerId,
        this.branchPriceId,
        this.centerName,
        this.userId,
        this.parentPhone,
        this.parentName,
        this.priceAmount,
        this.enrollmentType,
        this.responseSpeed,
        this.enrollmentDate,
        this.status,
        this.startingTime,
        this.endingTime,
        this.startingDate,
        this.endingDate,
        this.day,
        this.dayString,
        this.childrenCount,
        this.children});

  EnrollmentData.fromJson(json) {
    id = json['id'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    centerId = json['center_id'];
    branchPriceId = json['branch_price_id'];
    centerName = json['center_name'];
    userId = json['user_id'];
    parentPhone = json['parent_phone'];
    parentName = json['parent_name'];
    priceAmount = json['price_amount'];
    enrollmentType = json['enrollment_type'];
    responseSpeed = json['response_speed'];
    enrollmentDate = json['enrollment_date'];
    status = json['status'];
    startingTime = json['starting_time'];
    endingTime = json['ending_time'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    day = json['day'];
    dayString = json['day_string'];
    childrenCount = json['children_count'];
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
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['center_id'] = this.centerId;
    data['branch_price_id'] = this.branchPriceId;
    data['center_name'] = this.centerName;
    data['user_id'] = this.userId;
    data['parent_phone'] = this.parentPhone;
    data['parent_name'] = this.parentName;
    data['price_amount'] = this.priceAmount;
    data['enrollment_type'] = this.enrollmentType;
    data['response_speed'] = this.responseSpeed;
    data['enrollment_date'] = this.enrollmentDate;
    data['status'] = this.status;
    data['starting_time'] = this.startingTime;
    data['ending_time'] = this.endingTime;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    data['day'] = this.day;
    data['day_string'] = this.dayString;
    data['children_count'] = this.childrenCount;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int? id;
  String? childName;
  String? gender;

  Children({this.id, this.childName, this.gender});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    childName = json['child_name'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['child_name'] = this.childName;
    data['gender'] = this.gender;
    return data;
  }
}

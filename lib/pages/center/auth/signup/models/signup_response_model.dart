class SignupResponseModel {
  bool? success;
  Data? data;
  String? message;
  String? token;
  int? status;

  SignupResponseModel({this.success, this.data, this.message, this.status, this.token});

  SignupResponseModel.fromJson(json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? role;
  String? subscriptionStatus;
  String? freeTrialEndsAt;
  Center? center;

  Data({this.id, this.name, this.email, this.phone, this.role, this.subscriptionStatus, this.freeTrialEndsAt, this.center});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    subscriptionStatus = json['subscription_status'];
    freeTrialEndsAt = json['free_trial_ends_at'];
    center = json['center'] != null ? new Center.fromJson(json['center']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['subscription_status'] = this.subscriptionStatus;
    data['free_trial_ends_at'] = this.freeTrialEndsAt;
    if (this.center != null) {
      data['center'] = this.center!.toJson();
    }
    return data;
  }
}

class Center {
  String? nurseryName;
  String? location;
  int? cityId;
  String? neighborhood;
  String? phone;
  String? licensePath;
  String? logo;
  String? commercialRecordPath;
  List<String>? nurseryType;
  String? notes;

  Center(
      {this.nurseryName,
      this.location,
      this.cityId,
      this.neighborhood,
      this.phone,
      this.licensePath,
      this.logo,
      this.commercialRecordPath,
      this.nurseryType,
      this.notes});

  Center.fromJson(Map<String, dynamic> json) {
    nurseryName = json['nursery_name'];
    location = json['location'];
    cityId = json['city_id'];
    neighborhood = json['neighborhood'];
    phone = json['phone'];
    licensePath = json['license_path'];
    logo = json['logo'];
    commercialRecordPath = json['commercial_record_path'];
    nurseryType = json['nursery_type'].cast<String>();
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nursery_name'] = this.nurseryName;
    data['location'] = this.location;
    data['city_id'] = this.cityId;
    data['neighborhood'] = this.neighborhood;
    data['phone'] = this.phone;
    data['license_path'] = this.licensePath;
    data['logo'] = this.logo;
    data['commercial_record_path'] = this.commercialRecordPath;
    data['nursery_type'] = this.nurseryType;
    data['notes'] = this.notes;
    return data;
  }
}

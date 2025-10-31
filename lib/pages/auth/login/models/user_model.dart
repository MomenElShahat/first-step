class LoginResponseModel {
  String? message;
  String? token;
  int? status;
  User? user;

  LoginResponseModel({this.message, this.token, this.user, this.status});

  LoginResponseModel.fromJson(json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    data['status'] = status;
    if (this.user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? googleId;
  String? address;
  String? emailVerifiedAt;
  String? role;
  String? location;
  String? phone;
  String? neighborhood;
  String? createdAt;
  String? updatedAt;
  String? logo;
  String? nationalNumber;
  String? nurseryName;
  String? subscriptionStartDate;
  String? subscriptionEndDate;
  String? subscriptionStatus;
  String? subscriptionType;
  int? centerId;
  int? planId;
  int? branchId;
  int? isOnline;
  int? cityId;
  int? receiveNotifications;

  User(
      {this.id,
      this.name,
      this.email,
      this.googleId,
      this.address,
      this.emailVerifiedAt,
      this.role,
      this.location,
      this.phone,
      this.neighborhood,
      this.createdAt,
      this.updatedAt,
      this.logo,
      this.planId,
      this.subscriptionStartDate,
      this.subscriptionEndDate,
      this.subscriptionType,
      this.isOnline,
      this.cityId,
      this.branchId,
      this.nationalNumber,
      this.subscriptionStatus,
      this.nurseryName,
      this.receiveNotifications,
      this.centerId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    googleId = json['google_id'];
    address = json['address'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    location = json['location'];
    phone = json['phone'];
    neighborhood = json['neighborhood'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    centerId = json['center_id'];
    planId = json['plan_id'];
    isOnline = json["is_online"];
    cityId = json["city_id"];
    branchId = json["branch_id"];
    logo = json["logo"];
    nationalNumber = json["national_number"];
    nurseryName = json["nursery_name"];
    subscriptionStartDate = json["subscription_start_date"];
    subscriptionEndDate = json["subscription_end_date"];
    subscriptionStatus = json["subscription_status"];
    subscriptionType = json["type_of_duration"];
    receiveNotifications = json["receive_notifications"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['receive_notifications'] = this.receiveNotifications;
    data['email'] = this.email;
    data['google_id'] = this.googleId;
    data['address'] = this.address;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role'] = this.role;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['neighborhood'] = this.neighborhood;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['center_id'] = this.centerId;
    data['plan_id'] = this.planId;
    data["is_online"] = this.isOnline;
    data["city_id"] = this.cityId;
    data["branch_id"] = this.branchId;
    data["logo"] = this.logo;
    data["national_number"] = this.nationalNumber;
    data["nursery_name"] = this.nurseryName;
    data["subscription_start_date"] = this.subscriptionStartDate;
    data["subscription_end_date"] = this.subscriptionEndDate;
    data["subscription_status"] = this.subscriptionStatus;
    data["type_of_duration"] = this.subscriptionType;
    return data;
  }
}

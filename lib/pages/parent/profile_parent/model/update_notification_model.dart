class UpdateNotificationModel {
  bool? success;
  Data? data;
  String? message;
  int? status;

  UpdateNotificationModel({this.success, this.data, this.message, this.status});

  UpdateNotificationModel.fromJson(json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  String? role;
  int? receiveNotifications;
  String? fcmToken;
  String? nationalNumber;
  String? phone;
  String? address;

  Data({this.id, this.name, this.email, this.role, this.receiveNotifications, this.fcmToken, this.nationalNumber, this.phone, this.address});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    receiveNotifications = json['receive_notifications'];
    fcmToken = json['fcm_token'];
    nationalNumber = json['national_number'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['receive_notifications'] = this.receiveNotifications;
    data['fcm_token'] = this.fcmToken;
    data['national_number'] = this.nationalNumber;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}

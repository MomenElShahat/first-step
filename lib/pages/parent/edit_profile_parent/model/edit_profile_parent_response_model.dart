class EditProfileParentResponseModel {
  String? message;
  Parent? parent;

  EditProfileParentResponseModel({this.message, this.parent});

  EditProfileParentResponseModel.fromJson(json) {
    message = json['message'];
    parent =
    json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    return data;
  }
}

class Parent {
  int? id;
  String? name;
  String? email;
  String? role;
  String? nationalNumber;
  String? phone;
  String? address;

  Parent(
      {this.id,
        this.name,
        this.email,
        this.role,
        this.nationalNumber,
        this.phone,
        this.address});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
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
    data['national_number'] = this.nationalNumber;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}

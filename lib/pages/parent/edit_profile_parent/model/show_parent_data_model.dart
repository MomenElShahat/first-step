class ShowParentDataModel {
  Data? data;

  ShowParentDataModel({this.data});

  ShowParentDataModel.fromJson(json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? role;
  String? nationalNumber;
  String? phone;
  String? address;

  Data(
      {this.id,
        this.name,
        this.email,
        this.role,
        this.nationalNumber,
        this.phone,
        this.address});

  Data.fromJson(Map<String, dynamic> json) {
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

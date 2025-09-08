class DailyReportsDetailsModel {
  DailyReportsDetails? data;

  DailyReportsDetailsModel({this.data});

  DailyReportsDetailsModel.fromJson(json) {
    data = json['data'] != null ? new DailyReportsDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DailyReportsDetails {
  int? id;
  String? activities;
  String? meals;
  String? napTime;
  String? behavior;
  String? notes;
  String? createdAt;
  Child? child;
  Center? center;
  String? pdfUrl;

  DailyReportsDetails(
      {this.id,
        this.activities,
        this.meals,
        this.napTime,
        this.behavior,
        this.notes,
        this.createdAt,
        this.child,
        this.center,
        this.pdfUrl});

  DailyReportsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activities = json['activities'];
    meals = json['meals'];
    napTime = json['nap_time'];
    behavior = json['behavior'];
    notes = json['notes'];
    createdAt = json['created_at'];
    child = json['child'] != null ? new Child.fromJson(json['child']) : null;
    center =
    json['center'] != null ? new Center.fromJson(json['center']) : null;
    pdfUrl = json['pdf_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activities'] = this.activities;
    data['meals'] = this.meals;
    data['nap_time'] = this.napTime;
    data['behavior'] = this.behavior;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    if (this.child != null) {
      data['child'] = this.child!.toJson();
    }
    if (this.center != null) {
      data['center'] = this.center!.toJson();
    }
    data['pdf_url'] = this.pdfUrl;
    return data;
  }
}

class Child {
  int? id;
  String? name;
  String? gender;
  String? birthday;
  String? parentName;
  String? motherName;
  User? user;

  Child(
      {this.id,
        this.name,
        this.gender,
        this.birthday,
        this.parentName,
        this.motherName,
        this.user});

  Child.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    birthday = json['birthday'];
    parentName = json['parent_name'];
    motherName = json['mother_name'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['birthday'] = this.birthday;
    data['parent_name'] = this.parentName;
    data['mother_name'] = this.motherName;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? address;
  Null? phone;

  User({this.id, this.name, this.email, this.address, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phone'] = this.phone;
    return data;
  }
}

class Center {
  int? id;
  String? name;
  String? location;
  String? phone;
  Branch? branch;

  Center({this.id, this.name, this.location, this.phone, this.branch});

  Center.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    phone = json['phone'];
    branch =
    json['branch'] != null ? new Branch.fromJson(json['branch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['phone'] = this.phone;
    if (this.branch != null) {
      data['branch'] = this.branch!.toJson();
    }
    return data;
  }
}

class Branch {
  int? id;
  String? name;

  Branch({this.id, this.name});

  Branch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

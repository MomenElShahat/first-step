class SendReportResponseModel {
  final String message;
  final List<DailyReportData> data;

  SendReportResponseModel({
    required this.message,
    required this.data,
  });

  factory SendReportResponseModel.fromJson(json) {
    return SendReportResponseModel(
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => DailyReportData.fromJson(e))
          .toList(),
    );
  }
}

class DailyReportData {
  final int id;
  final String activities;
  final String meals;
  final String napTime;
  final String behavior;
  final String notes;
  final String createdAt;
  final Child child;
  final Center center;
  final String pdfUrl;

  DailyReportData({
    required this.id,
    required this.activities,
    required this.meals,
    required this.napTime,
    required this.behavior,
    required this.notes,
    required this.createdAt,
    required this.child,
    required this.center,
    required this.pdfUrl,
  });

  factory DailyReportData.fromJson(Map<String, dynamic> json) {
    return DailyReportData(
      id: json['id'],
      activities: json['activities'],
      meals: json['meals'],
      napTime: json['nap_time'],
      behavior: json['behavior'],
      notes: json['notes'],
      createdAt: json['created_at'],
      child: Child.fromJson(json['child']),
      center: Center.fromJson(json['center']),
      pdfUrl: json['pdf_url'],
    );
  }
}

class Child {
  final int id;
  final String name;
  final String gender;
  final String birthday;
  final String parentName;
  final String motherName;
  final User user;

  Child({
    required this.id,
    required this.name,
    required this.gender,
    required this.birthday,
    required this.parentName,
    required this.motherName,
    required this.user,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      birthday: json['birthday'],
      parentName: json['parent_name'],
      motherName: json['mother_name'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String? name;
  final String? email;
  final String? address;
  final String? phone;

  User({
    required this.id,
    this.name,
    this.email,
    this.address,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
    );
  }
}

class Center {
  final int id;
  final String name;
  final String location;
  final String phone;
  final Branch branch;

  Center({
    required this.id,
    required this.name,
    required this.location,
    required this.phone,
    required this.branch,
  });

  factory Center.fromJson(Map<String, dynamic> json) {
    return Center(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      phone: json['phone'],
      branch: Branch.fromJson(json['branch']),
    );
  }
}

class Branch {
  final int id;
  final String name;

  Branch({
    required this.id,
    required this.name,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'],
      name: json['name'],
    );
  }
}

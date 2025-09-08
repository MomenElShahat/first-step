class PlansModel {
  List<Plan>? data;

  PlansModel({this.data});

  PlansModel.fromJson(json) {
    if (json['data'] != null) {
      data = <Plan>[];
      json['data'].forEach((v) {
        data!.add(new Plan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plan {
  int? id;
  String? name;
  int? durationMonths;
  String? price;
  String? authUserStatus;
  String? createdAt;
  String? publishedAt;

  Plan(
      {this.id,
        this.name,
        this.durationMonths,
        this.price,
        this.authUserStatus,
        this.createdAt,
        this.publishedAt});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    durationMonths = json['duration_months'];
    price = json['price'];
    authUserStatus = json['auth_user_status'];
    createdAt = json['created_at'];
    publishedAt = json['published_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['duration_months'] = this.durationMonths;
    data['price'] = this.price;
    data['auth_user_status'] = this.authUserStatus;
    data['created_at'] = this.createdAt;
    data['published_at'] = this.publishedAt;
    return data;
  }
}

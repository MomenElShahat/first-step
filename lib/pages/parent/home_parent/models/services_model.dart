class ServicesParentResponseModel {
  List<Service>? data;

  ServicesParentResponseModel({this.data});

  ServicesParentResponseModel.fromJson(json) {
    if (json['data'] != null) {
      data = <Service>[];
      json['data'].forEach((v) {
        data!.add(new Service.fromJson(v));
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

class Service {
  int? id;
  String? title;
  String? description;
  String? image;
  String? createdAt;
  String? publishedAt;

  Service(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.createdAt,
        this.publishedAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    publishedAt = json['published_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['published_at'] = this.publishedAt;
    return data;
  }
}

class BranchTeamMemberModel {
  Data? data;

  BranchTeamMemberModel({this.data});

  BranchTeamMemberModel.fromJson(json) {
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
  String? profession;
  String? imageUrl;
  int? branchId;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.name, this.profession, this.imageUrl, this.branchId, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profession = json['profession'];
    imageUrl = json['image_url'];
    branchId = json['branch_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profession'] = this.profession;
    data['image_url'] = this.imageUrl;
    data['branch_id'] = this.branchId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

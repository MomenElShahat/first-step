class BranchTeamModel {
  List<TeamMember>? data;

  BranchTeamModel({this.data});

  BranchTeamModel.fromJson(json) {
    if (json['data'] != null) {
      data = <TeamMember>[];
      json['data'].forEach((v) {
        data!.add(new TeamMember.fromJson(v));
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

class TeamMember {
  int? id;
  String? name;
  String? profession;
  String? imageUrl;
  int? branchId;
  String? createdAt;
  String? updatedAt;

  TeamMember({this.id, this.name, this.profession, this.imageUrl, this.branchId, this.createdAt, this.updatedAt});

  TeamMember.fromJson(Map<String, dynamic> json) {
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

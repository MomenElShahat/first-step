class CenterNotifyParentsResponseModel {
  String? message;
  List<NotificationParents>? notificationParents;

  CenterNotifyParentsResponseModel({this.message, this.notificationParents});

  CenterNotifyParentsResponseModel.fromJson(json) {
    message = json['message'];
    if (json['notification_parents'] != null) {
      notificationParents = <NotificationParents>[];
      json['notification_parents'].forEach((v) {
        notificationParents!.add(new NotificationParents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.notificationParents != null) {
      data['notification_parents'] =
          this.notificationParents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationParents {
  int? id;
  String? name;
  String? role;
  String? description;

  NotificationParents({this.id, this.name, this.role, this.description});

  NotificationParents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['role'] = this.role;
    data['description'] = this.description;
    return data;
  }
}

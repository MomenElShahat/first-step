class ParentNotificationsModel {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  String? readAt;
  String? createdAt;
  String? updatedAt;
  int? reportId;
  String? title;
  String? description;
  String? date;
  String? time;

  ParentNotificationsModel(
      {this.id,
        this.type,
        this.notifiableType,
        this.notifiableId,
        this.readAt,
        this.createdAt,
        this.updatedAt,
        this.reportId,
        this.title,
        this.description,
        this.date,
        this.time});

  ParentNotificationsModel.fromJson(json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reportId = json['report_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['notifiable_type'] = this.notifiableType;
    data['notifiable_id'] = this.notifiableId;
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['report_id'] = this.reportId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}

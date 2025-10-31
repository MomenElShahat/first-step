class CenterNotifyParentsRequestModel {
  List<int>? parentIds;
  String? title;
  String? date;
  String? time;

  CenterNotifyParentsRequestModel(
      {this.parentIds, this.title, this.date, this.time});

  CenterNotifyParentsRequestModel.fromJson(json) {
    parentIds = json['parent_ids'].cast<int>();
    title = json['title'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent_ids'] = this.parentIds;
    data['title'] = this.title;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}

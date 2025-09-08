class CheckCodeResponseModel {
  bool? status;
  String? message;

  CheckCodeResponseModel({this.status, this.message});

  CheckCodeResponseModel.fromJson(json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

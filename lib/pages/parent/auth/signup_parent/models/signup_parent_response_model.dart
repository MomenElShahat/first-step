class SignupParentResponseModel {
  String? message;

  SignupParentResponseModel({this.message});

  SignupParentResponseModel.fromJson(json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}

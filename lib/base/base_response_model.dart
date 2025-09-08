class BaseResponseModel {
  int? code;
  Data? data;
  List<String>? errors;

  BaseResponseModel({this.code, this.data});

  BaseResponseModel.fromJson(json) {
    print("json)json) $json");
    code = json['code'];
    errors = json['errors'].cast<String>();
    if(json['data'] != null && json['data'].isNotEmpty){
      data = json['data'] != null ? Data.fromJson(json['data']) : null;
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['errors'] = errors;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? message;

  Data({this.message});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}

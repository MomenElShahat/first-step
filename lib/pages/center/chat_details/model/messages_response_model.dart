import 'message_model.dart';

class MessagesResponseModel {
  final MessagesModel? message;

  MessagesResponseModel({this.message});

  factory MessagesResponseModel.fromJson(dynamic json) {
    if (json == null) return MessagesResponseModel();
    final msgJson = json['message'];
    if (msgJson is Map<String, dynamic>) {
      return MessagesResponseModel(message: MessagesModel.fromJson(msgJson));
    } else {
      return MessagesResponseModel();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      if (message != null) 'message': message!.toJson(),
    };
  }
}

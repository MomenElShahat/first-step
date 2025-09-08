class MessagesResponseModel {
  Message? message;

  MessagesResponseModel({this.message});

  MessagesResponseModel.fromJson(json) {
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  int? senderId;
  String? receiverId;
  String? message;
  String? image;
  String? videoUrl;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? imageUrl;
  String? videoUrlPath;

  Message(
      {this.senderId,
        this.receiverId,
        this.message,
        this.image,
        this.videoUrl,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.imageUrl,
        this.videoUrlPath});

  Message.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    image = json['image'];
    videoUrl = json['video_url'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    imageUrl = json['image_url'];
    videoUrlPath = json['video_url_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['message'] = this.message;
    data['image'] = this.image;
    data['video_url'] = this.videoUrl;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['video_url_path'] = this.videoUrlPath;
    return data;
  }
}

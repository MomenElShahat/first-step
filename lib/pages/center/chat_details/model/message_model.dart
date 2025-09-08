class MessagesModel {
  int? id;
  int? senderId;
  int? receiverId;
  String? message;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? videoUrl;
  int? isRead;
  String? imageUrl;
  String? videoUrlPath;

  MessagesModel(
      {this.id,
        this.senderId,
        this.receiverId,
        this.message,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.videoUrl,
        this.isRead,
        this.imageUrl,
        this.videoUrlPath});

  MessagesModel.fromJson(json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    videoUrl = json['video_url'];
    isRead = json['is_read'];
    imageUrl = json['image_url'];
    videoUrlPath = json['video_url_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['message'] = this.message;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['video_url'] = this.videoUrl;
    data['is_read'] = this.isRead;
    data['image_url'] = this.imageUrl;
    data['video_url_path'] = this.videoUrlPath;
    return data;
  }
}

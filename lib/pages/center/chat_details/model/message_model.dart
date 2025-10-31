class MessagesModel {
  final int? id;
  final int? senderId;
  final String? receiverId;
  final String? message;
  final String? image;
  final String? imageUrl;
  final String? videoUrl;
  final String? videoUrlPath;
  final bool? isRead;
  final bool? isReadAdmin;
  final bool? isAdminMessage;
  final String? createdAt;
  final String? updatedAt;

  MessagesModel({
    this.id,
    this.senderId,
    this.receiverId,
    this.message,
    this.image,
    this.imageUrl,
    this.videoUrl,
    this.videoUrlPath,
    this.isRead,
    this.isReadAdmin,
    this.isAdminMessage,
    this.createdAt,
    this.updatedAt,
  });

  // helper parse methods
  static int? _parseInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is String) return int.tryParse(v);
    return null;
  }

  static bool? _parseBool(dynamic v) {
    if (v == null) return null;
    if (v is bool) return v;
    if (v is int) return v != 0;
    if (v is String) {
      final lower = v.toLowerCase();
      if (lower == 'true' || lower == '1') return true;
      if (lower == 'false' || lower == '0') return false;
    }
    return null;
  }

  static String? _parseString(dynamic v) {
    if (v == null) return null;
    return v.toString();
  }

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
    return MessagesModel(
      id: _parseInt(json['id']),
      senderId: _parseInt(json['sender_id']),
      receiverId: _parseString(json['receiver_id']),
      message: _parseString(json['message']),
      image: _parseString(json['image']),
      imageUrl: _parseString(json['image_url']),
      videoUrl: _parseString(json['video_url']),
      videoUrlPath: _parseString(json['video_url_path']),
      isRead: _parseBool(json['is_read']),
      isReadAdmin: _parseBool(json['is_read_admin']),
      isAdminMessage: _parseBool(json['is_admin_message']),
      createdAt: _parseString(json['created_at']),
      updatedAt: _parseString(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message,
      'image': image,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'video_url_path': videoUrlPath,
      'is_read': isRead,
      'is_read_admin': isReadAdmin,
      'is_admin_message': isAdminMessage,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

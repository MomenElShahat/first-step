// ignore: one_member_abstracts
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import '../../../../../base/base_auth_provider.dart';
import '../../../../base/api_end_points.dart';
import '../model/message_model.dart';
import '../model/messages_response_model.dart';



abstract class IChatDetailsProvider {
  Future<Response<List<MessagesModel>>> getMessages(String chatId);
  Future<Response<MessagesResponseModel>> sendMessages({required String message,required String receiverId, File? videoUrl,
    File? image,Progress? onUploadProgress});
}

class ChatDetailsProvider extends BaseAuthProvider implements IChatDetailsProvider {
  @override
  Future<Response<List<MessagesModel>>> getMessages(String chatId) {
    return get<List<MessagesModel>>(
      "${EndPoints.messages}/$chatId",
      decoder: (data) {
        final jsonList = data as List<dynamic>;
        return jsonList.map((e) => MessagesModel.fromJson(Map<String, dynamic>.from(e))).toList();
      },
    );
  }

  @override
  Future<Response<MessagesResponseModel>> sendMessages({
    required String message,
    required String receiverId,
    File? videoUrl,
    File? image,
    Progress? onUploadProgress,
  }) {
    final formData = FormData({
      'receiver_id': receiverId,
      'message': message,
    });

    if (videoUrl != null) {
      formData.files.add(
        MapEntry(
          'video_url',
          MultipartFile(videoUrl, filename: videoUrl.path.split(Platform.pathSeparator).last),
        ),
      );
    }

    if (image != null) {
      formData.files.add(
        MapEntry(
          'image',
          MultipartFile(image, filename: image.path.split(Platform.pathSeparator).last),
        ),
      );
    }

    return post<MessagesResponseModel>(
      EndPoints.messages,
      formData,
      uploadProgress: onUploadProgress,
      decoder: (data) => MessagesResponseModel.fromJson(data),
    );
  }
}

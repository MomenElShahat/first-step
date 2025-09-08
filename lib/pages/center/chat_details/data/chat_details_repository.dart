import 'dart:io';

import 'package:get/get_connect/http/src/http.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../../base/base_repositroy.dart';
import '../model/message_model.dart';
import '../model/messages_response_model.dart';
import 'chat_details_api_provider.dart';

abstract class IChatDetailsRepository {
  Future<Response<List<MessagesModel>>> getMessages(String chatId);
  Future<Response<MessagesResponseModel>> sendMessages({required String message,required String receiverId, File? videoUrl,
    File? image,Progress? onUploadProgress});
}

class ChatDetailsRepository extends BaseRepository implements IChatDetailsRepository {
  ChatDetailsRepository({required this.provider});
  final IChatDetailsProvider provider;


  @override
  Future<Response<List<MessagesModel>>> getMessages(String chatId) async {
    final apiResponse = await provider.getMessages(chatId);
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200) || apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }

  @override
  Future<Response<MessagesResponseModel>> sendMessages({required String message,required String receiverId, File? videoUrl,
    File? image,Progress? onUploadProgress}) async {
    final apiResponse = await provider.sendMessages(message: message,receiverId: receiverId,videoUrl: videoUrl,image: image,onUploadProgress:onUploadProgress);
    print(apiResponse.bodyString);
    if (apiResponse.isOk && apiResponse.body != null && (apiResponse.statusCode == 200) || apiResponse.statusCode == 201) {
      return apiResponse;
    } else {
      print(apiResponse.bodyString);
      print(apiResponse.statusCode);
      throw (getErrorMessage(apiResponse.bodyString!));
    }
  }
}

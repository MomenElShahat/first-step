import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:first_step/pages/center/control_panel/presentation/controllers/control_panel_controller.dart';
import 'package:first_step/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../consts/colors.dart';
import '../../../../../services/pusher_service.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../parent/control_panel_parent/presentation/controllers/control_panel_parent_controller.dart';
import '../../../control_panel/models/chats_model.dart';
import '../../data/chat_details_repository.dart';
import '../../model/message_model.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import "package:http/http.dart" as http;

import '../../model/messages_response_model.dart';

class ChatDetailsScreenController extends SuperController<dynamic> {
  ChatDetailsScreenController({required this.chatDetailsRepository});

  final IChatDetailsRepository chatDetailsRepository;

  // final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

  List<MessagesModel>? messages;
  List<XFile> pickedFiles = [];

  // Future<void> pickFiles() async {
  //   final result = await FilePicker.platform.pickFiles(
  //       allowMultiple: false, withData: true
  //   );
  //   if (result != null) {
  //     final compressed = <PlatformFile>[];
  //     for (final f in result.files) {
  //       final ext = f.extension?.toLowerCase() ?? '';
  //       if (ext.startsWith("jp") || ext == "png") {
  //         final im = decodeImage(f.bytes!)!;
  //         final comp = encodeJpg(im, quality: 70);
  //         compressed.add(PlatformFile(
  //             name: f.name, size: comp.length, bytes: comp, path: f.path, identifier: f.extension));
  //       } else {
  //         compressed.add(f);
  //       }
  //     }
  //     pickedFiles.addAll(compressed);
  //     update();
  //   }
  // }
  File? selectedImage;
  File? selectedVideo;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      pickedFiles.add(XFile(pickedFile.path));
      update();
    }
  }

  Future<void> pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedVideo = File(pickedFile.path);
      pickedFiles.add(XFile(pickedFile.path));
      update();
    }
  }

  void removeFile(int i) {
    pickedFiles.removeAt(i);
    update();
  }

  double uploadProgress = 0.0;

  getMessages() async {
    change(false, status: RxStatus.loading());
    chatDetailsRepository.getMessages(receiverId ?? "").then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          messages = null;
          messages = value.body;
          Future.delayed(
            const Duration(milliseconds: 300),
            () => scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            ),
          );
          update();
          change(true, status: RxStatus.success());
        }
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      change(true, status: RxStatus.success());
    });
  }

  ScrollController scrollController = ScrollController();
  MessagesResponseModel? sendMessageResponse;
  bool isSending = false;

  sendMessages({
    required String message,
    File? videoUrl,
    File? image,
  }) async {
    isSending = true;
    uploadProgress = 0.0;
    update();
    chatDetailsRepository
        .sendMessages(
            message: message,
            receiverId: receiverId ?? "",
            videoUrl: videoUrl,
            image: image,
            onUploadProgress: (progress) {
              uploadProgress = progress;
              update();
            })
        .then(
      (value) async {
        if (value.statusCode == 200 || value.statusCode == 201) {
          sendMessageResponse = null;
          sendMessageResponse = value.body;
          update();
        }
        isSending = false;
        uploadProgress = 0.0;
        Future.delayed(
          const Duration(milliseconds: 300),
          () => scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
        );
        update();
      },
    ).onError((error, stackTrace) {
      print("Signup error: $error");
      print("StackTrace: $stackTrace");
      customSnackBar(error.toString(), ColorCode.danger600);
      uploadProgress = 0.0;
      isSending = false;
      update();
    });
  }

  TextEditingController inputController = TextEditingController();

  // Future<void> _initPusher() async {
  //   try {
  //     await _pusher.init(
  //       apiKey: "d96caeb137f6e3295d24",
  //       cluster: "ap2",
  //       onEvent: _onPusherEvent,
  //       // FIX these 👇
  //       onSubscriptionSucceeded: (channelName, data) {
  //         print("Subscribed to $channelName with data: $data");
  //       },
  //       onConnectionStateChange: (currentState, previousState) {
  //         print("Connection changed from $previousState to $currentState");
  //       },
  //       onError: (message, code, exception) {
  //         print("Pusher error: $message | code: $code | exception: $exception");
  //       },
  //     );
  //
  //     await _pusher.subscribe(channelName: 'chat$receiverId');
  //     await _pusher.connect();
  //     await _initPusherChats();
  //   } catch (e) {
  //     print("Pusher initialization error: $e");
  //   }
  // }
  //
  // void _onPusherEvent(PusherEvent event) {
  //   print("Pusher event received: ${event.eventName}");
  //
  //   if (event.eventName == 'new-message') {
  //     try {
  //       final parsed = jsonDecode(event.data ?? '{}');
  //       final newMessage = MessagesModel(
  //           senderId: parsed['sender_id'],
  //           message: parsed['message'],
  //           imageUrl: parsed['image_url'],
  //           videoUrl: parsed['video_url'],
  //           image: parsed["image"],
  //           receiverId: parsed['receiver_id'],
  //           createdAt: parsed["created_at"],
  //           id: parsed["id"],
  //           isRead: parsed["is_read"],
  //           updatedAt: parsed["updated_at"],
  //           videoUrlPath: parsed["video_url_path"]);
  //
  //       messages?.add(newMessage);
  //       Future.delayed(
  //         const Duration(milliseconds: 300),
  //         () => scrollController.animateTo(
  //           scrollController.position.maxScrollExtent,
  //           duration: const Duration(milliseconds: 300),
  //           curve: Curves.easeOut,
  //         ),
  //       );
  //       update();
  //     } catch (e) {
  //       print("Error parsing real-time message: $e");
  //     }
  //   }
  // }

  String? name;
  String? receiverId;

  String getFirstTwoCapitalLetters(String input) {
    String trimmed = input.trim();

    if (trimmed.length < 2) return '';

    // Arabic check
    final arabicRegex = RegExp(r'^[\u0600-\u06FF\s]+$');
    final englishRegex = RegExp(r'^[a-zA-Z\s]+$');

    if (arabicRegex.hasMatch(trimmed)) {
      // Extract first two Arabic letters
      List<String> letters = trimmed.runes
          .where((r) =>
              RegExp(r'[\u0600-\u06FF]').hasMatch(String.fromCharCode(r)))
          .take(1)
          .map((r) => String.fromCharCode(r))
          .toList();

      return letters.length == 1 ? letters[0] : '';
    }

    if (englishRegex.hasMatch(trimmed)) {
      String firstTwo = trimmed.substring(0, 2);
      return firstTwo.toUpperCase();
    }

    return '';
  }

  // // ChatsModel chats = [];
  // Future<void> _initPusherChats() async {
  //   try {
  //     await _pusher.init(
  //       apiKey: "d96caeb137f6e3295d24",
  //       cluster: "ap2",
  //       onEvent: _onPusherEventChats,
  //       // FIX these 👇
  //       onSubscriptionSucceeded: (channelName, data) {
  //         print("Subscribed to $channelName with data: $data");
  //       },
  //       onConnectionStateChange: (currentState, previousState) {
  //         print("Connection changed from $previousState to $currentState");
  //       },
  //       onError: (message, code, exception) {
  //         print("Pusher error: $message | code: $code | exception: $exception");
  //       },
  //     );
  //
  //     await _pusher.subscribe(
  //         channelName: 'chat-list.${AuthService.to.userInfo?.user?.id}');
  //     await _pusher.connect();
  //   } catch (e) {
  //     print("Pusher initialization error: $e");
  //   }
  // }
  //
  // void _onPusherEventChats(PusherEvent event) {
  //   print("Pusher event received: ${event.eventName}");
  //
  //   if (event.eventName == 'chat-list-updated') {
  //     try {
  //       final parsed = jsonDecode(event.data ?? '[]');
  //
  //       if (parsed is List) {
  //         if (AuthService.to.userInfo?.user?.role == "parent") {
  //           final ControlPanelParentController controller = Get.find();
  //           controller.chats =
  //               parsed.map((item) => ChatsModel.fromJson(item)).toList();
  //           controller.update();
  //
  //         } else if (AuthService.to.userInfo?.user?.role == "center") {
  //           final ControlPanelController controller = Get.find();
  //           controller.chats =
  //               parsed.map((item) => ChatsModel.fromJson(item)).toList();
  //           controller.update();
  //
  //         }
  //       } else {
  //         print("Unexpected data format from Pusher: $parsed");
  //       }
  //     } catch (e) {
  //       print("Error parsing real-time message: $e");
  //     }
  //   }
  // }
  //
  // @override
  // void onInit() async {
  //   var args = Get.arguments;
  //   receiverId = args["receiverId"];
  //   name = args["name"];
  //   print("name $name");
  //   print("receiverId $receiverId");
  //   // Future.delayed(
  //   //   const Duration(milliseconds: 300),
  //   //   () => scrollController.animateTo(
  //   //     scrollController.position.maxScrollExtent,
  //   //     duration: const Duration(milliseconds: 300),
  //   //     curve: Curves.easeOut,
  //   //   ),
  //   // );
  //   await getMessages();
  //   await _initPusher();
  //
  //   super.onInit();
  // }
  //
  // @override
  // void onClose() async {
  //   await _pusher.unsubscribe(channelName: 'chat$receiverId');
  //   // Do not disconnect unless this is the last screen using Pusher
  //   super.onClose();
  // }

  @override
  void onInit() async {
    super.onInit();

    var args = Get.arguments;
    receiverId = args["receiverId"];
    name = args["name"];

    await getMessages();
    await _subscribeToChat();
    await _subscribeToChatList(); // optional
  }

  Future<void> _subscribeToChat() async {
    if (receiverId == null) return;

    await PusherService.to.subscribe(
      channelName: 'chat.$receiverId',
      eventName: 'new-message',
      onEvent: (data) {
        try {
          final parsed = jsonDecode(data);
          final newMessage = MessagesModel(
            senderId: parsed['sender_id'],
            message: parsed['message'],
            imageUrl: parsed['image_url'],
            videoUrl: parsed['video_url'],
            image: parsed["image"],
            receiverId: parsed['receiver_id'],
            createdAt: parsed["created_at"],
            id: parsed["id"],
            isRead: parsed["is_read"],
            updatedAt: parsed["updated_at"],
            videoUrlPath: parsed["video_url_path"],
          );
          messages?.add(newMessage);
          Future.delayed(
            const Duration(milliseconds: 300),
                () => scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            ),
          );
          update();
        } catch (e) {
          print("Error parsing new-message: $e");
        }
      },
    );
  }

  Future<void> _subscribeToChatList() async {
    final userId = AuthService.to.userInfo?.user?.id;
    if (userId == null) return;

    await PusherService.to.subscribe(
      channelName: 'chat-list.$userId',
      eventName: 'chat-list-updated',
      onEvent: (data) {
        try {
          final parsed = jsonDecode(data) as Map<String, dynamic>;
          final contactsJson = parsed["contacts"] as List<dynamic>;
          if (contactsJson.isNotEmpty ) {
            if (AuthService.to.userInfo?.user?.role == "parent") {
              final parentController = Get.find<ControlPanelParentController>();
              parentController.chats =
                  contactsJson.map((e) => Contacts.fromJson(e)).toList();
              parentController.update();
            } else {
              final centerController = Get.find<ControlPanelController>();
              centerController.chats =
                  contactsJson.map((e) => Contacts.fromJson(e)).toList();
              centerController.update();
            }
          }
        } catch (e) {
          print("Error parsing chat-list-updated in chat detail: $e");
        }
      },
    );
  }

  @override
  void onClose() async {
    if (receiverId != null) {
      await PusherService.to.unsubscribe('chat$receiverId');
    }
    super.onClose();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}

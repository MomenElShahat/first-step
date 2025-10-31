// ignore: one_member_abstracts
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../../base/api_end_points.dart';
import '../../../../base/base_auth_provider.dart';
import '../../../../services/auth_service.dart';
import '../models/login_request.dart';
import '../models/user_model.dart';

abstract class ILoginProvider {
  Future<Response<LoginResponseModel>> login(LoginRequest loginRequest);

  Future<Response<LoginResponseModel>> loginWithGoogle({required String token});
}

class LoginProvider extends BaseAuthProvider implements ILoginProvider {
  @override
  Future<Response<LoginResponseModel>> login(LoginRequest loginRequest) {
    FirebaseMessaging.instance.getToken().then((token) {
      String fcmToken = token ?? "";
      AuthService.fcmToken = fcmToken;
    });
    log("${{
      "email": loginRequest.email,
      "password": loginRequest.password,
      "fcm_token": AuthService.fcmToken
    }}");
    return post<LoginResponseModel>(
      EndPoints.loginV2,
      {
        "email": loginRequest.email,
        "password": loginRequest.password,
        "fcm_token": AuthService.fcmToken
      },
      decoder: LoginResponseModel.fromJson,
    );
  }

  @override
  Future<Response<LoginResponseModel>> loginWithGoogle(
      {required String token}) {
    log("google token $token");
    FirebaseMessaging.instance.getToken().then((token) {
      String fcmToken = token ?? "";
      AuthService.fcmToken = fcmToken;
    });
    return post<LoginResponseModel>(
      EndPoints.loginWithGoogle,
      {"token": token, "fcm_token": AuthService.fcmToken},
      decoder: LoginResponseModel.fromJson,
    );
  }
}

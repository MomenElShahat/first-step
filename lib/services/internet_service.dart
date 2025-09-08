import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

class InternetService extends GetxService{
  static InternetService get to => Get.find();
  final Connectivity connectivity = Connectivity();

  Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
  }


  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }




    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    connectionStatus.value = result.first;
    if(connectionStatus.value.toString() ==
        "ConnectivityResult.none"){
      print("NO INTERNET0");
    }else{
      print("yes INTERNET0");

    }
  }





  bool checkConnection() {
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    return connectionStatus.value != ConnectivityResult.none;
  }

  @override
  void onClose() {
    super.onClose();
    connectivitySubscription.cancel();
  }

}
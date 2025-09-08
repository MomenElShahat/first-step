// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
// class InternetConnectivityProvider with ChangeNotifier {
//   ConnectivityResult _connectivityResult = ConnectivityResult.none;
//
//   ConnectivityResult get connectivityResult => _connectivityResult;
//
//   Future<void> checkConnectivity() async {
//     final connectivity = Connectivity();
//     final result = await connectivity.checkConnectivity();
//     _connectivityResult = result;
//     notifyListeners();
//   }
//
// }
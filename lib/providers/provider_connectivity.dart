// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class ProviderConnectivity extends ChangeNotifier {
  bool connectivityState = false;

  void updateConnectivityState() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      connectivityState = true;
    } else {
      connectivityState = false;
    }
    notifyListeners();
  }
}

// class ProviderConnectivity {
//   bool connectivityState = false;
//
//   StreamController<bool> _connectivityController = StreamController();
//   Stream<bool> get connectivityStateStream => _connectivityController.stream;
//
//   void updateConnectivityState() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.mobile ||
//         connectivityResult == ConnectivityResult.wifi) {
//       _connectivityController.sink.add(true);
//     } else {
//       _connectivityController.sink.add(false);
//     }
//   }
//
//   void dispose() {
//     this._connectivityController.close();
//   }
// }

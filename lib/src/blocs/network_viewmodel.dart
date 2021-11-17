import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class NetworkViewModel extends GetxController {
  var connectionStatus = 0.obs;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  _updateConnectionStatus(ConnectivityResult result) async {
    try {
      result = await Connectivity().checkConnectivity();
    } catch (e) {
      print(e);
    }
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        SmartDialog.showToast("mất kết nối wifi");
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        SmartDialog.showToast("mất kết nối mobile");
        break;
      case ConnectivityResult.none:
        SmartDialog.showToast("mất kết nối internet");
        connectionStatus.value = 0;
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
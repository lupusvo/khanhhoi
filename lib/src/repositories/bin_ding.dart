import 'package:get/get.dart';
import 'package:sea_demo01/src/controller/network_viewmodel.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkViewModel());
  }
}
import 'package:get/state_manager.dart';
import 'package:sea_demo01/src/Services/cqapi.dart';

class InfoUserController extends GetxController {
  var isLoading = true.obs;
  String fullName = "";
  String userName = "";
  String address = "";
  String email = "";
  String numberPhone = "";

  @override
  void onInit() {
    fetchInfoUser();
    super.onInit();
  }

  void fetchInfoUser() async {
    try {
      isLoading(true);
      var userInfo = await CQAPI.getInfoUserByUserName();
      if (userInfo != null) {
         fullName = userInfo.fullName;
         userName = userInfo.userName;
         address = userInfo.address;
         email = userInfo.email;
         numberPhone = userInfo.numberPhone;

      }
    } finally {
      isLoading(false);
    }
  }
}
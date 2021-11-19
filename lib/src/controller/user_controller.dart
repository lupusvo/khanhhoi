import 'package:get/state_manager.dart';
import 'package:sea_demo01/src/Services/cqapi.dart';
import 'package:sea_demo01/src/model/infouser_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoUserController extends GetxController {
  var isLoading = true.obs;
  var userData = InfoUser.obs;

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
        userData = userInfo;
        final pref = await SharedPreferences.getInstance();
        pref.setString("idUser", userData.id.toString());
      }
    } finally {
      isLoading(false);
    }
  }
}
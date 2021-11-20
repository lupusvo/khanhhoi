import 'package:get/state_manager.dart';
import 'package:sea_demo01/src/Services/cqapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var loginProcess = false.obs;
  var error = "";
  String token = "";
  Future<String> login({required String UserName, required String PassWord,required int Type}) async {
    error = "";
    try {
      loginProcess(true);
      List loginResp = await CQAPI.login(UserName: UserName, PassWord: PassWord, Type: Type);
      if (loginResp[0] != "") {
        //success
        token = loginResp[0];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token.replaceAll('"',''));
        prefs.setString('user', UserName);
        prefs.setString('pass', PassWord);
      } else {
        error = loginResp[1];
      }
    } finally {
      loginProcess(false);
    }
    return error;
  }
}
import 'dart:convert' as convert;
import 'package:dart_ipify/dart_ipify.dart';
import 'package:http/http.dart' as http;
import 'package:sea_demo01/src/model/error_login_model.dart';
import 'package:sea_demo01/src/model/infouser_model.dart';
import 'package:sea_demo01/src/model/login_model.dart';
import 'package:sea_demo01/src/model/shipuser_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CQAPI {
  static var client = http.Client();
  static const _baseURL = "https://i-sea.khanhhoi.net";
  static String ip = Ipify.ipv4().toString();

  static Future<List> login(
      {required String UserName,
      required String PassWord,
      required int Type}) async {
    Uri uri = Uri.parse(_baseURL + '/home/login');
    Map body = {"UserName_": UserName, "pass_": PassWord, "type_": Type};
    var response = await client.post(uri,
        headers: <String, String>{
          'ClientIP': '192.168.2.54', // Ipify.ipv4().toString()
        },
        body: convert.json.encode(body));
    if (response.statusCode == 200) {
      String json = response.body.replaceAll('"','');
      var loginRes = LoginResp(accessToken: json);
      if (loginRes.accessToken != "null") {
        return [loginRes.accessToken];
      } else {
        return ["Unknown Error"];
      }
    } else {
      var json = response.body;
      var errorResp = errorRespFromJson(json);
      if (errorResp == null) {
        return ["Unknown Error"];
      } else {
        return [errorResp.error];
      }
    }
  }

  static Future<InfoUser> getInfoUserByUserName() async {
      final prefs = await SharedPreferences.getInstance();
      String apiKey = prefs.getString('token').toString();
      String username = prefs.getString('user').toString();
      var url = Uri.parse(_baseURL+"/api/user/getInfobyUsername/"+username.toString());
      Map<String, String> requestHeaders = {
        'ClientIP': '192.168.2.54',//Ipify.ipv4().toString().trim(),
        'ApiKey': apiKey.trim(),
      };
      final response = await http.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        InfoUser infoUser = infoUserFromMap(jsonResponse);
        final pref = await SharedPreferences.getInstance();
        pref.setString("idUser", infoUser.id.toString());
        return infoUser;
      } else {
        throw Exception('Failed to load info user');
      }
    }

  static Future<List<AllShipByUserId>> getAllShipByUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String apiKey = prefs.getString('token').toString();
    String id = prefs.getString('idUser').toString();
    var url = Uri.parse(_baseURL+"/api/Ship/getAllship/"+ id.toString());
    Map<String, String> requestHeaders = {
      'ClientIP': '192.168.2.54',//Ipify.ipv4().toString()
      'ApiKey': apiKey.trim()
    };
    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      return allShipByUserIdFromJson(jsonResponse);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}

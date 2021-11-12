import 'dart:async';
import 'package:sea_demo01/src/model/shipuser_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AllShip{
  List<AllShipByUserId> allShipByUserId = [];
  List<AllShipByUserId> runingShipByUserId = [];
  Future<void> getAllShipByUserId() async {
    final prefs = await SharedPreferences.getInstance();
    var ApiKey = prefs.getString('token');
    var id = prefs.getString('_id');
    String _id = id.toString();
    var url = Uri.parse('https://i-sea.khanhhoi.net/api/Ship/getAllship/'+_id);
    final String ip = await Ipify.ipv4().toString();
    Map<String, String> requestHeaders = {
       'ClientIP': ip,
       'ApiKey': ApiKey.toString(),
     };
    var response = await http.get(url,headers:requestHeaders);
    
    var jsonData = convert.jsonDecode(response.body);
    List<dynamic> body = convert.jsonDecode(response.body);
    allShipByUserId = body.map((dynamic item) => AllShipByUserId.fromJson(item)).toList();
    for(int i = 0 ; i < allShipByUserId.length;i++){
      String receivedJson = "... Your JSON string ....";
      if(allShipByUserId[i].statusID == 3){
        runingShipByUserId.add(allShipByUserId[i]);
      }
    }
  }
}
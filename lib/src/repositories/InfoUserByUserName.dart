import 'package:sea_demo01/src/model/infouser_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class InfoUserByUserName{
    late InfoUser _InfoUser;
    Future<InfoUser> getInfoUserByUserName() async {
      final prefs = await SharedPreferences.getInstance();
      final ApiKey = prefs.getString('token');
      final username = prefs.getString('user');
      var url = Uri.parse(
          'https://i-sea.khanhhoi.net/api/user/getInfobyUsername/'+username.toString());
      final String ip = await Ipify.ipv4().toString();
      Map<String, String> requestHeaders = {
        'ClientIP': ip,
        'ApiKey': ApiKey.toString(),
      };
      final response = await http.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        _InfoUser = InfoUser.fromJson(convert.jsonDecode(response.body));
        var _id = prefs.setString("_id", _InfoUser.id.toString());
        return _InfoUser;
      } else {
        throw Exception('Failed to load info user');
      }
    }
}
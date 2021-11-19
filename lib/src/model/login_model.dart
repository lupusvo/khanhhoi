import 'dart:convert';

LoginResp loginRespFromJson(String str) => LoginResp.fromJson(json.decode(str));

String loginRespToJson(LoginResp data) => json.encode(data.toJson());


class LoginResp {
  late String accessToken;
  LoginResp({
    required this.accessToken,
  });
  factory LoginResp.fromJson(Map<String, dynamic> json) => LoginResp(
      accessToken: json["access_token"],
  );
  Map<String, dynamic> toJson() => {
    "access_token": accessToken 
  };
}
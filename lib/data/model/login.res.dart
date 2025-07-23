// To parse this JSON data, do
//
//     final loginRes = loginResFromJson(jsonString);

import 'dart:convert';

LoginRes loginResFromJson(String str) => LoginRes.fromJson(json.decode(str));

String loginResToJson(LoginRes data) => json.encode(data.toJson());

class LoginRes {
    String accessToken;
    String tokenType;
    String type;
    String id;
    String message;

    LoginRes({
        required this.accessToken,
        required this.tokenType,
        required this.type,
        required this.id,
        required this.message,
    });

    factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        type: json["type"],
        id: json["id"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "type": type,
        "id": id,
        "message": message,
    };
}

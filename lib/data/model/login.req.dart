// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
    String grantType;
    String username;
    String password;
    String scope;
    String clientId;
    String clientSecret;

    LoginRequest({
        required this.grantType,
        required this.username,
        required this.password,
        required this.scope,
        required this.clientId,
        required this.clientSecret,
    });

    factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        grantType: json["grant_type"],
        username: json["username"],
        password: json["password"],
        scope: json["scope"],
        clientId: json["client_id"],
        clientSecret: json["client_secret"],
    );

    Map<String, dynamic> toJson() => {
        "grant_type": grantType,
        "username": username,
        "password": password,
        "scope": scope,
        "client_id": clientId,
        "client_secret": clientSecret,
    };
}

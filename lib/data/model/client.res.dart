// To parse this JSON data, do
//
//     final clientInitRes = clientInitResFromJson(jsonString);

import 'dart:convert';

ClientInitRes clientInitResFromJson(String str) => ClientInitRes.fromJson(json.decode(str));

String clientInitResToJson(ClientInitRes data) => json.encode(data.toJson());

class ClientInitRes {
    String message;
    String clientId;
    String clientSecret;

    ClientInitRes({
        required this.message,
        required this.clientId,
        required this.clientSecret,
    });

    factory ClientInitRes.fromJson(Map<String, dynamic> json) => ClientInitRes(
        message: json["message"],
        clientId: json["client_id"],
        clientSecret: json["client_secret"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "client_id": clientId,
        "client_secret": clientSecret,
    };
}

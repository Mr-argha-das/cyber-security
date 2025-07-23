// To parse this JSON data, do
//
//     final clientInitBody = clientInitBodyFromJson(jsonString);

import 'dart:convert';

ClientInitBody clientInitBodyFromJson(String str) => ClientInitBody.fromJson(json.decode(str));

String clientInitBodyToJson(ClientInitBody data) => json.encode(data.toJson());

class ClientInitBody {
    String ip;

    ClientInitBody({
        required this.ip,
    });

    factory ClientInitBody.fromJson(Map<String, dynamic> json) => ClientInitBody(
        ip: json["ip"],
    );

    Map<String, dynamic> toJson() => {
        "ip": ip,
    };
}

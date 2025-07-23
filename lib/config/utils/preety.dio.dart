import 'dart:developer';
import 'package:aithena/data/db/db.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';


import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<Dio> xxxUrlEncoder() async {
  final dio = Dio();

  // if (!Hive.isBoxOpen('userdata')) {
  //   await Hive.openBox('userdata');
  // }
  // final box = Hive.box('userdata');
  // final token = box.get('@token');
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
    ),
  );
  log(" ${HiveService().getData("auth-key", "@AUTH")?['token'] ?? ""}");

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Retrieve token before sending request
        options.headers.addAll({
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization':
              'Bearer ${HiveService().getData("auth-key", "@AUTH")?['token'] ?? ""}',
        });
        handler.next(options); // Continue with the request
      },
      onResponse: (response, handler) {
        if (response.data['code'] == 401 && response.data['error'] == true) {

          HiveService().clearAll("@AUTH");

         
        } else {
          handler.next(response);
        }
      },
    
      onError: (DioException e, handler) async {
        if (e.response?.data == 401) {
          // Token expired, refresh it
          log("Token expired, refreshing...");

          return;
        } else {
          handler.next(e);
        }
      },
    ),
  );

  return dio;
}
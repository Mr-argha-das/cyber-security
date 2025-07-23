

import 'package:aithena/data/model/client.req.dart';
import 'package:aithena/data/model/client.res.dart';
import 'package:aithena/data/model/login.req.dart';
import 'package:aithena/data/model/login.res.dart';
import 'package:dio/dio.dart';


import 'package:retrofit/retrofit.dart' hide Headers;

part 'api.state.g.dart';

@RestApi(baseUrl: 'https://aa37ff9561fd.ngrok-free.app/api')
abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _APIStateNetwork;
  @POST("/auth/client-init")
  Future<ClientInitRes> getCLientSecret(@Body() ClientInitBody body);
  @POST("/auth/login")
  Future<HttpResponse> login(@Body() LoginRequest body);  
}

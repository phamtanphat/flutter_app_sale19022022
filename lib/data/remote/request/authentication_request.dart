import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/model/request/login_request.dart';
import 'package:flutter_app_sale19022022/data/remote/client/dio_client.dart';

class AuthenticationRequest{

  late Dio _dio;

  AuthenticationRequest(){
    _dio = DioClient.instance.dio;
  }

  Future<Response> loginRequest(LoginRequest loginRequest){
    return _dio.post("user/sign-in" , data: loginRequest.toJson());
  }
}
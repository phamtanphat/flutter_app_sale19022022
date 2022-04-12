import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/model/request/login_request.dart';
import 'package:flutter_app_sale19022022/data/model/request/sign_up_request.dart';
import 'package:flutter_app_sale19022022/data/remote/request/authentication_request.dart';

class AuthenticationRepository {
  late AuthenticationRequest _request;

  AuthenticationRepository();

  void updateAuthenticationRepository(
      {required AuthenticationRequest request}) {
    this._request = request;
  }

  Future<Response> loginRepo(String email, String password) {
    return _request
        .loginRequest(LoginRequest(email: email, password: password));
  }

  Future<Response> signUpRepo(String email, String password, String address, String name, String phone) {
    return _request.signUpRequest(SignUpRequest(
        email: email,
        password: password,
        address: address,
        name: name,
        phone: phone));
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_app_sale19022022/data/model/response/user_response.dart';

enum LoginStatus { initial, loading, loginSuccess , refreshToken , refreshTokenFail , loginFail }

class LoginState extends Equatable{
  LoginStatus? status;
  UserResponse? userResponse;
  String? message = null;

  LoginState._({this.status,this.userResponse, this.message});

  LoginState copyWith({LoginStatus? status,UserResponse? response , String? message}) {
    return LoginState._(
      status: status ?? this.status,
      userResponse: response ?? this.userResponse,
      message: message ?? this.message,
    );
  }

  LoginState.initial() : this._(status : LoginStatus.initial);
  LoginState.loading() : this._(status : LoginStatus.loading);
  LoginState.loginSuccess({required UserResponse? userResponse}) : this._(status : LoginStatus.loginSuccess , userResponse : userResponse);
  LoginState.loginFail({required String? message}) : this._(status : LoginStatus.loginFail , message : message);


  @override
  List<Object?> get props => [status,userResponse,message];
}
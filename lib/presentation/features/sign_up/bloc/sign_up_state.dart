import 'package:equatable/equatable.dart';
import 'package:flutter_app_sale19022022/data/model/response/user_response.dart';

enum SignUpStatus { initial, loading, success, fail }

class SignUpState extends Equatable {
  SignUpStatus? status;
  UserResponse? userResponse;
  String? message = null;

  SignUpState._({this.status, this.userResponse, this.message});

  SignUpState copyWith(
      {SignUpStatus? status, UserResponse? response, String? message}) {
    return SignUpState._(
      status: status ?? this.status,
      userResponse: response ?? this.userResponse,
      message: message ?? this.message,
    );
  }

  SignUpState.initial() : this._(status: SignUpStatus.initial);

  SignUpState.loading() : this._(status: SignUpStatus.loading);

  SignUpState.success({required UserResponse? userResponse})
      : this._(status: SignUpStatus.success, userResponse: userResponse);

  SignUpState.fail({required String? message})
      : this._(status: SignUpStatus.fail, message: message);

  @override
  List<Object?> get props => [status, userResponse, message];
}

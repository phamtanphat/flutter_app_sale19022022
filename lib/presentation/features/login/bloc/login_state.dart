import 'package:equatable/equatable.dart';
import 'package:flutter_app_sale19022022/data/model/response/user_response.dart';

abstract class LoginStateBase extends Equatable{

}

class LoginStateInit extends LoginStateBase{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginLoading extends LoginStateBase{
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginStateBase{
  late UserResponse userResponse;

  LoginSuccess({required this.userResponse});

  @override
  List<Object?> get props => [userResponse];
}

class LoginFail extends LoginStateBase{
  late String message;

  LoginFail({required this.message});

  @override
  List<Object?> get props => [message];
}
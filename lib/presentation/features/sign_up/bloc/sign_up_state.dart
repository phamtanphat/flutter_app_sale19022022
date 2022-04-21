import 'package:equatable/equatable.dart';
import 'package:flutter_app_sale19022022/data/model/response/user_response.dart';

abstract class SignUpStateBase extends Equatable{

}

class SignUpStateInit extends SignUpStateBase{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpStateLoading extends SignUpStateBase{
  @override
  List<Object?> get props => [];
}

class SignUpStateSuccess extends SignUpStateBase{
  late UserResponse userResponse;

  SignUpStateSuccess({required this.userResponse});

  @override
  List<Object?> get props => [userResponse];
}

class SignUpStateFail extends SignUpStateBase{
  late String message;

  SignUpStateFail({required this.message});

  @override
  List<Object?> get props => [message];
}
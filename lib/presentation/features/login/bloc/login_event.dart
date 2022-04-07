import 'package:equatable/equatable.dart';

abstract class LogInEventBase extends Equatable {}

class LoginEvent extends LogInEventBase {
  late String email;
  late String password;

  LoginEvent({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

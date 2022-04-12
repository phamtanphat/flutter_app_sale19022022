import 'package:equatable/equatable.dart';

abstract class SignUpEventBase extends Equatable {}

class SignUpEvent extends SignUpEventBase {
  String email;
  String name;
  String password;
  String phone;
  String address;

  SignUpEvent({
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
    required this.address,
  });

  @override
  List<Object?> get props => [email, name, password, phone, address];
}

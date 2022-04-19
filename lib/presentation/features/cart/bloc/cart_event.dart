import 'package:equatable/equatable.dart';

abstract class CartEventBase extends Equatable {}

class FetchCartEvent extends CartEventBase{
  @override
  List<Object?> get props => [];
}
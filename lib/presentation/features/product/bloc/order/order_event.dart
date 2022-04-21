import 'package:equatable/equatable.dart';

abstract class OrderEventBase extends Equatable{

}

class FetchOrder extends OrderEventBase {

  FetchOrder();

  @override
  List<Object?> get props => [];
}

class AddOrder extends OrderEventBase {

  late String id_product;

  AddOrder({required this.id_product});

  @override
  List<Object?> get props => [id_product];
}
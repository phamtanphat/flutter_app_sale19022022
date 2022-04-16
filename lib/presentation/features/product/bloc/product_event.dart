import 'package:equatable/equatable.dart';

abstract class ProductEventBase extends Equatable {}

class FetchListProduct extends ProductEventBase {

  FetchListProduct();

  @override
  List<Object?> get props => [];
}

class FetchCart extends ProductEventBase {

  FetchCart();

  @override
  List<Object?> get props => [];
}

class AddCart extends ProductEventBase {

  late String id_product;

  AddCart({required this.id_product});

  @override
  List<Object?> get props => [id_product];
}
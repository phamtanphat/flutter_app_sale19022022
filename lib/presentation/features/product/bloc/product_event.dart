import 'package:equatable/equatable.dart';

abstract class ProductEventBase extends Equatable {}

class FetchListProduct extends ProductEventBase {

  FetchListProduct();

  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';
import 'package:flutter_app_sale19022022/data/model/response/order_response.dart';
import 'package:flutter_app_sale19022022/data/model/response/product_reponse.dart';

abstract class ProductStateBase extends Equatable{

}
class ProductStateInit extends ProductStateBase{

  @override
  List<Object?> get props => [];

}

class FetchProductsSuccess extends ProductStateBase{

  late List<ProductResponse> list;

  FetchProductsSuccess({required this.list});

  @override
  List<Object?> get props => [list];

}

class FetchProductsError extends ProductStateBase{

  late String message;

  FetchProductsError(String message){
    this.message = message;
  }

  @override
  List<Object?> get props => [message];

}

class FetchCartSuccess extends ProductStateBase{

  late OrderResponse orderResponse;

  FetchCartSuccess({required this.orderResponse});

  @override
  List<Object?> get props => [orderResponse];

}

class FetchCartError extends ProductStateBase{

  late String message;

  FetchCartError(String message){
    this.message = message;
  }

  @override
  List<Object?> get props => [message];

}

import 'package:equatable/equatable.dart';
import 'package:flutter_app_sale19022022/data/model/response/order_response.dart';

abstract class OrderStateBase extends Equatable{

  OrderResponse? orderResponse;

  OrderStateBase({OrderResponse? orderResponse});

  @override
  // TODO: implement props
  List<Object?> get props => [orderResponse];
}

class OrderStateInit extends OrderStateBase{

}

class FetchOrderSuccess extends OrderStateBase{

  FetchOrderSuccess.copyWith({OrderResponse? data}){
    orderResponse = data;
  }

  @override
  List<Object?> get props => [orderResponse];

}

class FetchOrderFail extends OrderStateBase{

  late String message;

  FetchOrderFail(String message){
    this.message = message;
  }

  @override
  List<Object?> get props => [message];

}

class AddOrderSuccess extends OrderStateBase{

  AddOrderSuccess.copyWith({OrderResponse? data}){
    orderResponse = data;
  }

  @override
  List<Object?> get props => [orderResponse];

}

class AddOrderFail extends OrderStateBase{

  late String message;

  AddOrderFail(String message){
    this.message = message;
  }

  @override
  List<Object?> get props => [message];

}
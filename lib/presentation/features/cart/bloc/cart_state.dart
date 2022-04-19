import 'package:equatable/equatable.dart';
import 'package:flutter_app_sale19022022/data/model/response/order_response.dart';

enum CartStatus { initial, loading, fetchCartSuccess, fetchCartFail }

class CartState extends Equatable {
  CartStatus? status;
  OrderResponse? orderResponse;
  String? message = null;

  CartState._({this.status, this.orderResponse, this.message});

  CartState copyWith(
      {CartStatus? status, OrderResponse? response, String? message}) {
    return CartState._(
      status: status ?? this.status,
      orderResponse: response ?? this.orderResponse,
      message: message ?? this.message,
    );
  }

  CartState.initial() : this._(status: CartStatus.initial);

  CartState.loading() : this._(status: CartStatus.loading);

  CartState.fetchCartSuccess({required OrderResponse? orderResponse})
      : this._(
            status: CartStatus.fetchCartSuccess, orderResponse: orderResponse);

  CartState.fetchCartFail({required String? message})
      : this._(status: CartStatus.fetchCartFail, message: message);

  @override
  List<Object?> get props => [status, orderResponse, message];
}

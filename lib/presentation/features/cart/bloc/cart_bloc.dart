import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/model/response/order_response.dart';
import 'package:flutter_app_sale19022022/data/remote/response/app_response.dart';
import 'package:flutter_app_sale19022022/data/repository/order_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/cart/bloc/cart_event.dart';
import 'package:flutter_app_sale19022022/presentation/features/cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEventBase, CartState> {
  late OrderRepository _orderRepository;

  CartBloc({required OrderRepository orderRepository})
      : super(CartState.initial()) {
    this._orderRepository = orderRepository;
    on<FetchCartEvent>((event, emit) async {
      emit(CartState.loading());
      try {
        Response response = await _orderRepository.fetchCart();
        AppResponse<OrderResponse> orderResponse =
            AppResponse.fromJson(response.data, OrderResponse.formJson);
        emit(CartState.fetchCartSuccess(orderResponse: orderResponse.data!));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(CartState.fetchCartFail(
              message: e.response!.data['message'].toString()));
        } else {
          emit(CartState.fetchCartFail(message: e.toString()));
        }
      } catch (e) {
        emit(CartState.fetchCartFail(message: e.toString()));
      }
    });
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/model/response/order_response.dart';
import 'package:flutter_app_sale19022022/data/remote/response/app_response.dart';
import 'package:flutter_app_sale19022022/data/repository/order_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/order/order_event.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/order/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEventBase, OrderStateBase> {
  late OrderRepository _orderRepository;

  OrderBloc({required OrderRepository orderRepository})
      : super(OrderStateInit()) {
    this._orderRepository = orderRepository;

    on<FetchOrder>((event, emit) async {
      try {
        Response response = await _orderRepository.fetchOrder();
        AppResponse<OrderResponse> orderResponse = AppResponse.fromJson(
            response.data, OrderResponse.formJson);
        emit(FetchOrderSuccess.copyWith(data: orderResponse.data!));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(FetchOrderFail(e.response!.data['message'].toString()));
        } else {
          emit(FetchOrderFail(e.error.toString()));
        }
      } catch (e) {
        emit(FetchOrderFail(e.toString()));
      }
    });

    on<AddOrder>((event, emit) async{
      try {
        Response response = await _orderRepository.addOrder(event.id_product);
        AppResponse<OrderResponse> orderResponse = AppResponse.fromJson(
            response.data, OrderResponse.formJson);
        emit(AddOrderSuccess.copyWith(data: orderResponse.data));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(AddOrderFail(e.response!.data['message'].toString()));
        } else {
          emit(AddOrderFail(e.error.toString()));
        }
      } catch (e) {
        emit(AddOrderFail(e.toString()));
      }
    });
  }
}

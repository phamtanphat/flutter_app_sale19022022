import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/model/response/order_response.dart';
import 'package:flutter_app_sale19022022/data/model/response/product_reponse.dart';
import 'package:flutter_app_sale19022022/data/remote/response/app_response.dart';
import 'package:flutter_app_sale19022022/data/repository/order_repository.dart';
import 'package:flutter_app_sale19022022/data/repository/product_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/product_event.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductOrderBloc extends Bloc<ProductEventBase, ProductStateBase> {
  late OrderRepository _orderRepository;

  ProductOrderBloc({required OrderRepository orderRepository})
      : super(ProductStateInit()) {
    this._orderRepository = orderRepository;

    on<FetchCart>((event, emit) async {
      emit(ProductStateLoading());
      try {
        Response response = await _orderRepository.fetchCart();
        AppResponse<OrderResponse> orderResponse = AppResponse.fromJson(
            response.data, OrderResponse.formJson);
        emit(FetchCartSuccess(orderResponse: orderResponse.data!));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(FetchCartError(e.response!.data['message'].toString()));
        } else {
          emit(FetchCartError(e.toString()));
        }
      } catch (e) {
        emit(FetchCartError(e.toString()));
      }
    });
  }
}

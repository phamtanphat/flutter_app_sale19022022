import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/model/response/order_response.dart';
import 'package:flutter_app_sale19022022/data/model/response/product_reponse.dart';
import 'package:flutter_app_sale19022022/data/remote/response/app_response.dart';
import 'package:flutter_app_sale19022022/data/repository/order_repository.dart';
import 'package:flutter_app_sale19022022/data/repository/product_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/product_event.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEventBase, ProductState> {
  late ProductRepository _productRepository;
  late OrderRepository _orderRepository;

  ProductBloc({required ProductRepository productRepository,
    required OrderRepository orderRepository})
      : super(ProductState.initial()) {
    this._productRepository = productRepository;
    this._orderRepository = orderRepository;

    on<FetchListProduct>((event, emit) async {
      emit(ProductState.loading());
      try {
        Response response = await _productRepository.fetchProducts();
        AppResponse<List<ProductResponse>> list = AppResponse.fromJson(response.data, (data) {
          return List<ProductResponse>.from(response.data["data"].map((e) => ProductResponse.fromJson(e)));
        });
        emit(ProductState.fetchDataSuccess(listProduct: list.data, orderResponse: null));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(ProductState.fetchDataFail(
              message: e.response!.data['message'].toString()));
        } else {
          emit(ProductState.fetchDataFail(message: e.toString()));
        }
      } catch (e) {
        emit(ProductState.fetchDataFail(message: e.toString()));
      }
    });

    on<FetchCart>((event, emit) async {
      emit(ProductState.loading());
      try {
        Response response = await _orderRepository.fetchCart();
        AppResponse<OrderResponse> orderResponse = AppResponse.fromJson(response.data, OrderResponse.formJson);
        emit(ProductState.fetchDataSuccess(orderResponse: orderResponse.data , listProduct: state.lstProducts));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(ProductState.fetchDataFail(
              message: e.response!.data['message'].toString()));
        } else {
          emit(ProductState.fetchDataFail(message: e.toString()));
        }
      } catch (e) {
        emit(ProductState.fetchDataFail(message: e.toString()));
      }
    });
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_app_sale19022022/data/model/response/product_reponse.dart';
import 'package:flutter_app_sale19022022/data/remote/response/app_response.dart';
import 'package:flutter_app_sale19022022/data/repository/product_repository.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/product/product_event.dart';
import 'package:flutter_app_sale19022022/presentation/features/product/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEventBase, ProductStateBase> {
  late ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
      : super(ProductStateInit()) {
    this._productRepository = productRepository;

    on<FetchListProduct>((event, emit) async {
      try {
        Response response = await _productRepository.fetchProducts();
        AppResponse<List<ProductResponse>> list =
            AppResponse.fromJson(response.data, (data) {
          return List<ProductResponse>.from(
              response.data["data"].map((e) => ProductResponse.fromJson(e)));
        });
        emit(FetchProductsSuccess(list: list.data!));
      } on DioError catch (e) {
        if (e.response != null) {
          emit(FetchProductsError(e.response!.data['message'].toString()));
        } else {
          emit(FetchProductsError(e.toString()));
        }
      } catch (e) {
        emit(FetchProductsError(e.toString()));
      }
    });

  }
}

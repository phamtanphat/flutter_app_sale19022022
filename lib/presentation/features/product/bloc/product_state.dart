import 'package:equatable/equatable.dart';
import 'package:flutter_app_sale19022022/data/model/response/order_response.dart';
import 'package:flutter_app_sale19022022/data/model/response/product_reponse.dart';

enum ProductStatus {
  initial,
  loading,
  fetchDataSuccess,
  fetchDataFail,
}

class ProductState extends Equatable {
  ProductStatus? status;
  List<ProductResponse>? lstProducts;
  OrderResponse? orderResponse;
  String? message = null;

  ProductState._(
      {this.status, this.lstProducts, this.orderResponse, this.message});

  ProductState copyWith(
      {ProductStatus? status,
      List<ProductResponse>? response,
      OrderResponse? orderResponse,
      String? message}) {
    return ProductState._(
      status: status ?? this.status,
      lstProducts: response ?? this.lstProducts,
      orderResponse: orderResponse ?? this.orderResponse,
      message: message ?? this.message,
    );
  }

  ProductState.initial() : this._(status: ProductStatus.initial);

  ProductState.loading() : this._(status: ProductStatus.loading);

  ProductState.fetchDataSuccess({
    required OrderResponse? orderResponse,
    required List<ProductResponse>? listProduct,
  }) : this._(
            status: ProductStatus.fetchDataSuccess,
            orderResponse: orderResponse,
            lstProducts: listProduct);

  ProductState.fetchDataFail({required String? message})
      : this._(status: ProductStatus.fetchDataFail, message: message);

  @override
  List<Object?> get props => [status, lstProducts, message];
}
